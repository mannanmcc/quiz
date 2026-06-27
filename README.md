# build Linux app to upload to VPS
docker run --rm \
  -v "$PWD":/src \
  -w /src \
  golang:1.25 \
  go build -o quizeapp-linux-amd64 ./cmd/server

Do not upload a locally built macOS `quizeapp` to a Linux VPS. Check with:

```bash
file quizeapp-linux-amd64
```

It should say `ELF 64-bit ... GNU/Linux`.

Upload these together when deploying dashboard changes:
- `quizeapp-linux-amd64` renamed to `quizeapp` on the VPS
- `templates/`
- `static/`

Then restart the app process on the server. Dashboard structure comes from
`templates/admin_dashboard.html`, and the tab/buttons use `static/js/app.js`;
uploading only `static/css/style.css` will not update the dashboard.



Note:
When you do upload templates and static and any others, remove from VPS and then re upload, this will make sure documents are uploaded successfully 

  
