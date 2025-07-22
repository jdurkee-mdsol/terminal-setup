#!/bin/zsh

# Help function
function show_help {
    echo "Usage: $0 [-p PATTERN]"
    echo ""
    echo "Options:"
    echo "  -p PATTERN     Optional pattern to filter namespaces"
    echo "  -h             Show this help message"
    exit 1
}

# Parse command line arguments
PATTERN=""
while getopts "p:h" opt; do
    case $opt in
        p) PATTERN="$OPTARG" ;;
        h) show_help ;;
        *) show_help ;;
    esac
done

# Load zsh aliases
source ~/.zshrc

# Get all namespaces
if [ -z "$PATTERN" ]; then
    # If no pattern provided, get all namespaces
    NAMESPACES=($(kaws get namespaces | tail -n +2 | awk '{print $1}'))
else
    # Get namespaces matching the pattern
    NAMESPACES=($(kaws get namespaces | grep "$PATTERN" | awk '{print $1}'))
fi

# Check if any namespaces were found
if [ ${#NAMESPACES[@]} -eq 0 ]; then
    echo "Error: No namespaces found"
    if [ ! -z "$PATTERN" ]; then
        echo "No namespaces matching pattern '$PATTERN'"
    fi
    exit 1
fi

# Display all namespaces
echo "Available Kubernetes namespaces:"
echo "-------------------------------"
for i in {1..${#NAMESPACES[@]}}; do
    echo "$i) ${NAMESPACES[$i]}"
done

# Prompt for selection
echo ""
echo -n "Select a namespace (1-${#NAMESPACES[@]}) or press Enter to exit: "
read selection

# Exit if no selection
if [ -z "$selection" ]; then
    exit 0
fi

# Validate selection
if ! [[ "$selection" =~ ^[0-9]+$ ]] || [ "$selection" -lt 1 ] || [ "$selection" -gt ${#NAMESPACES[@]} ]; then
    echo "Error: Invalid selection"
    exit 1
fi

SELECTED_NAMESPACE=${NAMESPACES[$selection]}
echo ""
echo "Selected namespace: $SELECTED_NAMESPACE"

# Ask if user wants to connect to a pod in this namespace
echo ""
echo -n "Do you want to connect to a pod in this namespace? (y/n): "
read connect_pod

if [[ "$connect_pod" =~ ^[Yy]$ ]]; then
    # Call pod-connect.sh with the selected namespace
    ~/Documents/docker/pod-connect.sh -n "$SELECTED_NAMESPACE"
else
    # Show pods in the namespace
    echo ""
    echo "Pods in namespace $SELECTED_NAMESPACE:"
    echo "-------------------------------"
    kaws get pods -n "$SELECTED_NAMESPACE"
fi
