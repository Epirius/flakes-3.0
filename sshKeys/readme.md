to decrypt the private key:
- with usb-c yubikey
    ```age -d -i ../usb-c-identity.txt -o id_ed25519 id_ed25519.age```
- with usb-a yubikey
    ``````age -d -i ../usb-a-identity.txt -o id_ed25519 id_ed25519.age```

move the public and decrypted private key to ~/.ssh