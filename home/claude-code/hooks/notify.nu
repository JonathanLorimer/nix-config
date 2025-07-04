def main [] {
    # Read and decode the notification input from stdin
    let notification_input = try {
        $in | from json
    } catch {
        print -e "Error decoding notification input from stdin"
        exit 2
    }

    # Extract title and message from the notification
    let title = $notification_input | get -i title | default "Claude Code"
    let message = $notification_input | get -i message | default ""

    # Validate that we have at least a title or message
    if ($title | str trim) == "" and ($message | str trim) == "" {
        print -e "No title or message found in notification input"
        exit 2
    }

    # Send notification using notify-send
    try {
        if ($message | str trim) != "" {
            ^notify-send $title $message
        } else {
            ^notify-send $title
        }
    } catch {
        print -e "Error sending notification with notify-send"
        exit 2
    }
}
