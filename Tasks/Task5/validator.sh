
#!/bin/bash
echo "This script validates user input for 'yes' or 'no'"
echo "Enter 'yes' or 'no':"
read user_input
if [[ "$user_input" == "yes" || "$user_input" == "no" ]]; then
    echo "You entered a valid response: $user_input"
else
    echo "Invalid input. Please enter 'yes' or 'no'."
fi
