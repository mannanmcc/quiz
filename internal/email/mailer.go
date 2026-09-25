package email

import (
	"fmt"
	"log"
	"net/mail"
	"net/smtp"
	"os"
	"strconv"
	"strings"
)

func sendingEnabled() bool {
	switch strings.ToLower(strings.TrimSpace(os.Getenv("EMAIL_SENDING_ENABLED"))) {
	case "1", "true", "yes", "on":
		return true
	default:
		return false
	}
}

func Send(to, subject, body string) error {
	if !sendingEnabled() {
		log.Printf("Email not sent to %s because EMAIL_SENDING_ENABLED is not enabled. Subject: %s", to, subject)
		return nil
	}

	host := strings.TrimSpace(os.Getenv("SMTP_HOST"))
	from := strings.TrimSpace(os.Getenv("SMTP_FROM"))
	if host == "" || from == "" {
		log.Printf("Email not sent to %s because SMTP_HOST and SMTP_FROM are not configured. Subject: %s", to, subject)
		return nil
	}

	fromAddress, err := mail.ParseAddress(from)
	if err != nil {
		return fmt.Errorf("invalid SMTP_FROM address: %w", err)
	}

	port := strings.TrimSpace(os.Getenv("SMTP_PORT"))
	if port == "" {
		port = "587"
	}

	username := strings.TrimSpace(os.Getenv("SMTP_USERNAME"))
	password := os.Getenv("SMTP_PASSWORD")

	headers := []string{
		fmt.Sprintf("From: %s", from),
		fmt.Sprintf("To: %s", to),
		fmt.Sprintf("Subject: %s", subject),
		"MIME-Version: 1.0",
		"Content-Type: text/plain; charset=UTF-8",
	}
	message := strings.Join(headers, "\r\n") + "\r\n\r\n" + body

	addr := host + ":" + port
	var auth smtp.Auth
	if username != "" || password != "" {
		auth = smtp.PlainAuth("", username, password, host)
	}

	if _, err := strconv.Atoi(port); err != nil {
		return fmt.Errorf("invalid SMTP_PORT: %w", err)
	}

	return smtp.SendMail(addr, auth, fromAddress.Address, []string{to}, []byte(message))
}
