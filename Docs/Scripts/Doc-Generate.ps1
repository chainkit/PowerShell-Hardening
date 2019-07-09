# Generate Markdown Help files
Import-Module .\Secure-ChainKit\Secure-ChainKit.psm1 -Force
New-MarkdownHelp -Module Secure-ChainKit -OutputFolder .\Docs

# Edit generated files

# Generate External Help files
# New-ExternalHelp .\Docs -OutputPath Secure-Chainkit\en-US\
