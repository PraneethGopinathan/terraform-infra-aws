# Create the IAM policy
resource "aws_iam_policy" "secretsmanager_policy" {
  name        = "secretsmanager_policy"
  description = "Policy to allow access to Secrets Manager secrets"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        "Resource": [
          "arn:aws:secretsmanager:ap-south-1:891330001860:secret:carsdevsecrets-KXQNPA"
        ]
      }
    ]
  })
}

# Create the IAM role
resource "aws_iam_role" "devcars_role" {
  name = "devcars_role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "arn:aws:iam::891330001860:oidc-provider/oidc.eks.ap-south-1.amazonaws.com/id/D6587681CAE4F493B2C793032627DBEF"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
          "StringEquals": {
            "oidc.eks.ap-south-1.amazonaws.com/id/D6587681CAE4F493B2C793032627DBEF:sub": "system:serviceaccount:default:secret-sa",
            "oidc.eks.ap-south-1.amazonaws.com/id/D6587681CAE4F493B2C793032627DBEF:aud": "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "devcars_policy_attachment" {
  role       = aws_iam_role.devcars_role.name
  policy_arn = aws_iam_policy.secretsmanager_policy.arn
}
