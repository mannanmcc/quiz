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

Email features need SMTP settings on the server:

```bash
export APP_BASE_URL="https://your-domain.example"
export EMAIL_SENDING_ENABLED="true"
export SMTP_HOST="smtp.example.com"
export SMTP_PORT="587"
export SMTP_USERNAME="your-smtp-username"
export SMTP_PASSWORD="your-smtp-password"
export SMTP_FROM="TEST <no-reply@your-domain.example>"
```

Email sending is disabled unless `EMAIL_SENDING_ENABLED` is set to `true`,
`1`, `yes`, or `on`.

Registration emails and password reset links are skipped when `SMTP_HOST` and
`SMTP_FROM` are not configured, so local development can still run without a
mail account.



Note:
When you do upload templates and static and any others, remove from VPS and then re upload, this will make sure documents are uploaded successfully 

  

## Exam boards and sequential sets

Students see a separate dashboard section for each published board for their stage.
Each section shows the current set and its papers, ready to start directly.
Each board offers only its current set on the dashboard. Completed boards remain
visible with a completion message.
Completing every paper unlocks the next published set for that board and stage;
there is no passing-score requirement. Papers within a set can be taken in either
order. Retakes and edits preserve completion progress. Unclassified papers (including the default General type) and unassigned
personalized practice are excluded from the student dashboard.

In **Admin → Exam Sets**, create a board/stage set with a
positive sequence number. Use **Add Set** beside an exam type to preselect that type. New sets are drafts.
Use **Add Exam** beside a draft set to open the exam form with its type, stage
and set selected. Use **Find & Assign Exam** beside a draft set to search existing
exams and move one into it. Assignment updates the paper’s stage and exam type
to match the set and preserves questions and attempts. Archived papers, personalized
practice, and papers in sets students have started cannot be moved this way.
Create or edit papers to select
that set and set their display order, then publish the complete set. For CSSE,
10 Maths and 10 English papers can form 10 sets with two papers each. A GL set
can contain Paper 1 (English / Verbal Reasoning) and Paper 2 (Maths / Non-verbal
Reasoning), using paper titles/descriptions to identify the subjects.

Unpublish an unstarted set before adding papers. Once a student opens a paper,
the set's membership, paper order and publication state are fixed. Earlier sets
cannot be inserted or reordered into a sequence that students have already
started. Question corrections remain possible; questions with recorded answers
cannot be removed. Existing attempts and completion progress are retained.

Startup migrates existing sets by stage, assigns deterministic sequence numbers,
and retains legacy publication and attempt history. Review migrated sets in the
admin dashboard before using them for new students. Unassigned imported papers
are grouped by board and stage at startup; personalized assignments are excluded.
The bundled vocabulary seed runs once per database, so restarting cannot overwrite
admin stage/archive changes. Back up the SQLite database before deploying the
migration, then deploy the server, templates and static assets together.

Run checks with `go test ./...`.

## Reading passages

On Create/Edit Test, use **Reading passage / shared context** to enter one or
more paragraphs and choose the number of related questions. Click **Add passage
and questions**, fill in those questions and answers, then save the exam. Repeat
for additional passages. Each question's **Edit Context** button lets you inspect
or adjust its passage. Consecutive questions with the same context display that
passage once before the group; paragraph breaks are preserved. Reading context
is student-facing, unlike the admin-only exam description.

Question text starts as a single-line field. Use **Use multiple lines** on an
individual question when its wording needs paragraph breaks, and switch back
with **Use single line**. In **Add Diagram**, click the diagram area and paste a
graph or screenshot from the clipboard, choose an image file, or draw directly
on the canvas. Pasted and uploaded images are fitted into the diagram canvas and
saved with the question.
