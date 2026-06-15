package techpalace

import (
    "strings"
)

func WelcomeMessage(customer string) string {
	return "Welcome to the Tech Palace, " + strings.ToUpper(customer)
}

func AddBorder(welcomeMsg string, numStarsPerLine int) string {
    borderStr := strings.Repeat("*", numStarsPerLine)
	return borderStr + "\n" + welcomeMsg + "\n" + borderStr
}

func CleanupMessage(oldMsg string) string {
	return strings.Trim(oldMsg, "\n* ")
}
