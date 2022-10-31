# === Access ===

## SSH-Key
resource "tls_private_key" "bastion" {
  algorithm = "RSA"
  rsa_bits = "2048"
}
