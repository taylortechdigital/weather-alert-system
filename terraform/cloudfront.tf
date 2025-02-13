resource "aws_cloudfront_distribution" "frontend_cf" {
  count = var.use_localstack ? 0 : 1

  origin {
    domain_name = aws_lb.frontend_alb[0].dns_name
    origin_id   = "ALB-Frontend"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only" # or "https-only" if your ALB enforces HTTPS
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront distribution for frontend ALB"
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id       = "ALB-Frontend"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }
    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
