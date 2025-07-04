# Claude Code Stop Hook Script in Nushell
# Reads stop hook input from stdin, processes transcript, and commits changes

def main [] {
    let diff_output = ^jj diff --no-pager
    if ($diff_output | is-empty) {
        exit 0
    }

    let stopHookInputJson: string = $in

    # Read and decode the stop hook input from stdin
    let stop_hook_input = try {
        $stopHookInputJson | from json
    } catch {
        print -e "Error decoding StopHookInput from stdin"
        exit 2
    }

    # Validate required fields
    if ($stop_hook_input | get -i session_id) == null {
        print -e "Missing session_id in input"
        exit 2
    }

    if ($stop_hook_input | get -i transcript_path) == null {
        print -e "Missing transcript_path in input"
        exit 2
    }

    let session_id = $stop_hook_input.session_id
    let transcript_path = $stop_hook_input.transcript_path

    # Check if transcript file exists
    if not ($transcript_path | path exists) {
        print -e $"Error: transcript file does not exist: ($transcript_path)"
        exit 2
    }

    # Read the first line of the transcript file
    let first_line = try {
        open $transcript_path | lines | first
    } catch {
        print -e $"Error reading first line of transcript: ($transcript_path)"
        exit 2
    }

    # Parse the transcript summary from the first line
    let transcript_summary = try {
        $first_line | from json
    } catch {
        print -e "Error decoding first line of transcript as JSON"
        exit 2
    }

    # Build the commit message
    let base_message = $"claude\(($session_id)\): automatic commit"

    let commit_message = if ($transcript_summary | get -i summary) != null and ($transcript_summary.summary | str trim) != "" {
        $"($base_message)\n\n($transcript_summary.summary)"
    } else {
        $base_message
    }

    # Run jj commit
    try {
        ^jj commit --message $commit_message
    } catch {
        print -e "Error running jj commit"
        exit 2
    }
}
