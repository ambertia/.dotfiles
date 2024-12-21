#! /bin/bash
# Convenience script to pretty print a heading in plaintext files like scripts with my typical formatting

# Retreive the heading from command line args and compute properties needed for the formatting
HEADING="$1"
shift
for token in "$@"
do
    HEADING="${HEADING} ${token}"
done
HEADING_LENGTH=$(($(echo $HEADING | wc -m) - 1)) # wc adds an extra character because it counts the newline
HYPHENS_TOTAL=$((66 - HEADING_LENGTH))

# If there is no heading text, default to 68 hyphens
if [[ $HEADING_LENGTH == 0 ]]; then
    HYPHENS_TOTAL=68
# If there is a heading, pad it with some spaces for convenience later
else
    HEADING=" ${HEADING} "
fi

HYPHENS_HEAD=$((HYPHENS_TOTAL / 2))
HYPHENS_TAIL=$((HYPHENS_TOTAL - HYPHENS_HEAD))

# Create a variable to store the formatted output
FORMAT_FINAL="# "
# Add head hyphens to the output
while [[ HYPHENS_HEAD -gt 0 ]]; do
    FORMAT_FINAL="${FORMAT_FINAL}-"
    HYPHENS_HEAD=$((HYPHENS_HEAD - 1))
done
# Add label to the output if applicable
FORMAT_FINAL="${FORMAT_FINAL}${HEADING}"
# Add tail hyphens to the formatted output
while [[ HYPHENS_TAIL -gt 0 ]]; do
    FORMAT_FINAL="${FORMAT_FINAL}-"
    HYPHENS_TAIL=$((HYPHENS_TAIL - 1))
done

echo $FORMAT_FINAL

