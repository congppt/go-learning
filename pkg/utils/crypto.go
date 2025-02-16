package utils

import "golang.org/x/crypto/bcrypt"

func Hash(value string) ([]byte, error) {
	// be careful with the cost, +1 makes hash run like 3x slower
	return bcrypt.GenerateFromPassword([]byte(value), 10)
}

func CompareHash(hashedValue []byte, plainValue string) error {
	return bcrypt.CompareHashAndPassword(hashedValue, []byte(plainValue))
}

func Encrypt(content string) string {
	return ""
}

func Decrypt(plainText string) string {
	return ""
}
