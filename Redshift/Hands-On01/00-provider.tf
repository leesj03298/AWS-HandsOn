provider "aws" {
    profile     = "default"
    region      = "ap-northeast-2"
    default_tags {
        tags = {    
            Environment = "KYO-DEV"
        }
    }
}