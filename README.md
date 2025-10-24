# how to setup ssh connection to github from win11

## Generate SSH Key Pair

- Open PowerShell or Windows Terminal.
- Run the command:

```plaintext
ssh-keygen -t ed25519 -C "your_email@example.com"
```

- Press Enter to accept default file location (usually `C:\Users\<yourname>\.ssh`) and set an optional passphrase.[^5][^6]

### Upload SSH Public Key to GitHub

- Open the file `id_ed25519.pub` (or `id_rsa.pub`) from your `.ssh` folder in Notepad.
- Log in to GitHub, go to Settings → SSH and GPG Keys → New SSH key.
- Paste your public key and save.[^7][^3]

### Test Your SSH Connection

- In PowerShell or Git Bash, run:

```plaintext
ssh -T git@github.com
```

- You should see a welcome/authentication message from GitHub.[^5]

### Use SSH for Git Operations

- When cloning or pushing, use the SSH URL (e.g., `git@github.com:username/repo.git`).
- All Git operations will securely use SSH now.[^9][^3]

This process establishes secure, token-free authentication with GitHub on Windows 11.[^3][^8]
`<span style="display:none">`[^11][^13][^14]

<div align="center">⁂</div>

[^1]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh
    
[^2]: https://davidaugustat.com/windows/windows-11-setup-ssh
    
[^3]: https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/GitHub-SSH-Windows-Example
    
[^4]: https://www.freecodecamp.org/news/how-to-use-ssh-to-connect-to-github-guide-for-windows/
    
[^5]: https://www.youtube.com/watch?v=9gkb81GKmVI
    
[^6]: https://www.youtube.com/watch?v=itU8KBuE8jk
    
[^7]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account
    
[^8]: https://stackoverflow.com/questions/71530073/how-to-use-the-ssh-key-that-i-configured-in-the-github-for-cli-git-push-on-wind
    
[^9]: https://dev.to/hbolajraf/git-connecting-to-github-and-pushing-changes-using-ssh-on-windows-2f5
    
[^10]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
    
[^11]: https://stackoverflow.com/questions/31813080/generate-new-ssh-keys-in-windows-10-11
    
[^12]: https://learn.microsoft.com/en-us/azure/devops/repos/git/use-ssh-keys-to-authenticate?view=azure-devops
    
[^13]: https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse
    
[^14]: https://www.purdue.edu/science/scienceit/ssh-keys-windows.html
