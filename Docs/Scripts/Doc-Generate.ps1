# Generate Markdown Help files
Import-Module .\Secure-ChainKit-v2\Secure-ChainKit.psm1 -Force
New-MarkdownHelp -Module Secure-ChainKit -OutputFolder .\docs

# Edit generated files

# Generate Help files
#New-ExternalHelp .\docs -OutputPath en-US\