// Package twofer is short for two for one. Package implements simple operation with string
package twofer

/*
ShareWith function transforms accepted string into sentence:
One for {name}, one for me.

For instance given name = "Ted"
returns "One for Ted, one for me."
*/
func ShareWith(name string) string {
	if name == "" {
		name = "you"
	}

	return "One for " + name + ", one for me."
}
