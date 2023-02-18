# GPG basic commands

[index](index.md)

## Generate key

```
gpg --full-generate-key
```

## List keys

```
gpg --list-secret-keys --keyid-format LONG
```

## Send keys

```
gpg --send-keys ${KEY_ID}
```

