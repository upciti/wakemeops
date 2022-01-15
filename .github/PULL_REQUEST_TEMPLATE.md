## Summary

<!-- short description of your change here -->

## Checklist

- [ ] CI tests are green.
- [ ] `pre-commit` Pre-Commit checks are good. Test locally with:

```bash
pre-commit run -a
```

**If you have added a new package:**

- [ ] `ops2deb format` ops2deb files are well formatted. Test locally with:

```bash
pipx install ops2deb
make format
```

Or with Docker:

```bash
# Run wakemebot container
docker run --pull=always -uroot -it  --rm -w /wakemeops -v $(pwd):/wakemeops upciti/wakemebot:main bash
# Run ops2deb format
make format
```

- [ ] `check-package`: test that your package works (from docker)

```bash
# Run wakemebot container
docker run --pull=always -uroot -it --rm -w /wakemeops -v $(pwd):/wakemeops upciti/wakemebot:main bash
# Installation and basic verification of your package inside the docker
make generate build install-packages check-packages
# And test your package (ex: $package --version)
```

<!-- Thank you for contributing to WakeMeOps! -->
