Add-Type -AssemblyName PresentationCore,PresentationFramework

function MsgBox([string] $message,[string] $title)
{
[System.Windows.MessageBox]::Show($message,$title)
}

MsgBox "Look a message Box" "Title"