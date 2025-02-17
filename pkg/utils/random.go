package utils

import (
	"math/rand"
	"strings"
)

const ALPHABET = "aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ"
const DIGITS = "1234567890"

func RandomInt(min, max int64) int64 {
	return min + rand.Int63n(max-min+1)
}

func randomString(length int, source string) string {
	var sb strings.Builder
	for i := 0; i < length; i++ {
		char := source[rand.Intn(len(source))]
		sb.WriteByte(char)
	}
	return sb.String()
}

func RandomStringWithDigit(length int) string {
	return randomString(length, ALPHABET+DIGITS)
}

func RandomString(length int) string {
	return randomString(length, ALPHABET)
}
