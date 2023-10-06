resource "aws_iam_role" "cross_account" {
  count              = var.repo_cross_account_role_name != "" ? 1 : 0
  name               = var.repo_cross_account_role_name
  description        = "Role for cross account access to ${var.repository_name} CodeCommit repo"
  assume_role_policy = data.aws_iam_policy_document.allowed_account_trust.json
  tags               = var.tags
}

data "aws_iam_policy_document" "allowed_account_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [for account_id in var.repo_allowed_aws_account_ids : "arn:aws:iam::${account_id}:root"]
    }
  }
}

data "aws_iam_policy_document" "cross_account" {
  statement {
    sid       = "AllowCodeCommitActions"
    effect    = "Allow"
    resources = [aws_codecommit_repository.this.arn]

    actions = [
      "codecommit:CancelUploadArchive",
      "codecommit:GetBranch",
      "codecommit:GetCommit",
      "codecommit:GetRepository",
      "codecommit:GetUploadArchiveStatus",
      "codecommit:UploadArchive",
    ]
  }

  statement {
    sid       = "AllowKMSActions"
    effect    = "Allow"
    resources = var.cross_account_kms_key_arns

    actions = [
      "kms:DescribeKey",
      "kms:GenerateDataKey",
      "kms:Encrypt",
      "kms:Decrypt",
    ]
  }

  statement {
    sid       = "AllowBucketActions"
    effect    = "Allow"
    resources = [for bucket_name in var.cross_account_codepipeline_bucket_names : "arn:aws:s3:::${bucket_name}"]

    actions = [
      "s3:ListBucket",
    ]
  }

  statement {
    sid       = "AllowBucketObjectActions"
    effect    = "Allow"
    resources = [for bucket_name in var.cross_account_codepipeline_bucket_names : "arn:aws:s3:::${bucket_name}/*"]

    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]
  }
}

resource "aws_iam_policy" "cross_account" {
  count       = var.repo_cross_account_role_name != "" ? 1 : 0
  name        = join("-", [var.repo_cross_account_role_name, "policy"])
  description = "Permissions for ${var.repo_cross_account_role_name}"
  policy      = data.aws_iam_policy_document.cross_account.json
  tags        = var.tags
}

resource "aws_iam_role_policy_attachment" "cross_account" {
  count      = var.repo_cross_account_role_name != "" ? 1 : 0
  role       = aws_iam_role.cross_account[0].name
  policy_arn = aws_iam_policy.cross_account[0].arn
}

resource "aws_codecommit_repository" "this" {
  repository_name = var.repository_name
  description     = var.description
  default_branch  = var.default_branch

  # Tags
  tags = var.tags
}
