// Login/Register Toggle
document.addEventListener('DOMContentLoaded', function() {
    const showRegister = document.getElementById('showRegister');
    const showForgotPassword = document.getElementById('showForgotPassword');
    const cancelRegister = document.getElementById('cancelRegister');
    const cancelForgotPassword = document.getElementById('cancelForgotPassword');
    const registerBox = document.getElementById('registerBox');
    const forgotBox = document.getElementById('forgotBox');
    const loginBox = document.querySelector('.login-box');
    const registerForm = document.getElementById('registerForm');
    const forgotPasswordForm = document.getElementById('forgotPasswordForm');
    const forgotMessage = document.getElementById('forgotMessage');

    if (showRegister) {
        showRegister.addEventListener('click', function(e) {
            e.preventDefault();
            loginBox.style.display = 'none';
            forgotBox.style.display = 'none';
            registerBox.style.display = 'block';
        });
    }

    if (showForgotPassword) {
        showForgotPassword.addEventListener('click', function(e) {
            e.preventDefault();
            loginBox.style.display = 'none';
            registerBox.style.display = 'none';
            forgotBox.style.display = 'block';
        });
    }

    if (cancelRegister) {
        cancelRegister.addEventListener('click', function() {
            registerBox.style.display = 'none';
            forgotBox.style.display = 'none';
            loginBox.style.display = 'block';
        });
    }

    if (cancelForgotPassword) {
        cancelForgotPassword.addEventListener('click', function() {
            forgotBox.style.display = 'none';
            registerBox.style.display = 'none';
            loginBox.style.display = 'block';
        });
    }

    if (registerForm) {
        registerForm.addEventListener('submit', async function(e) {
            e.preventDefault();
            
            const fullName = document.getElementById('reg_fullname').value;
            const username = document.getElementById('reg_username').value;
            const email = document.getElementById('reg_email').value;
            const password = document.getElementById('reg_password').value;
            const stageID = parseInt(document.getElementById('reg_stage').value, 10);

            try {
                const response = await fetch('/api/register', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        full_name: fullName,
                        username: username,
                        email: email,
                        password: password,
                        stage_id: stageID
                    })
                });

                if (response.ok) {
                    alert('Registration successful! Please login.');
                    registerBox.style.display = 'none';
                    loginBox.style.display = 'block';
                    registerForm.reset();
                } else {
                    const error = await response.text();
                    alert('Registration failed: ' + error);
                }
            } catch (error) {
                alert('Registration failed. Please try again.');
                console.error('Error:', error);
            }
        });
    }

    if (forgotPasswordForm) {
        forgotPasswordForm.addEventListener('submit', async function(e) {
            e.preventDefault();

            const email = document.getElementById('forgot_email').value;
            forgotMessage.style.display = 'none';
            forgotMessage.className = 'alert';

            try {
                const response = await fetch('/api/password-reset', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ email: email })
                });

                const message = await response.text();
                forgotMessage.style.display = 'block';
                if (response.ok) {
                    forgotMessage.classList.add('alert-success');
                    try {
                        forgotMessage.textContent = JSON.parse(message).message;
                    } catch (_) {
                        forgotMessage.textContent = 'If an account uses that email, a password reset link has been sent.';
                    }
                    forgotPasswordForm.reset();
                } else {
                    forgotMessage.classList.add('alert-error');
                    forgotMessage.textContent = message || 'Could not send reset link. Please try again.';
                }
            } catch (error) {
                forgotMessage.style.display = 'block';
                forgotMessage.classList.add('alert-error');
                forgotMessage.textContent = 'Could not send reset link. Please try again.';
                console.error('Error:', error);
            }
        });
    }

    const adminCreateStudentForm = document.getElementById('adminCreateStudentForm');
    if (adminCreateStudentForm) {
        adminCreateStudentForm.addEventListener('submit', async function(e) {
            e.preventDefault();

            const fullName = document.getElementById('student_fullname').value;
            const username = document.getElementById('student_username').value;
            const email = document.getElementById('student_email').value;
            const password = document.getElementById('student_password').value;
            const stageID = parseInt(document.getElementById('student_stage').value, 10);

            try {
                const response = await fetch('/api/register', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        full_name: fullName,
                        username: username,
                        email: email,
                        password: password,
                        stage_id: stageID
                    })
                });

                if (response.ok) {
                    window.location.href = `/admin/dashboard?registered=student&username=${encodeURIComponent(username)}#students`;
                } else {
                    const error = await response.text();
                    alert('Registration failed: ' + error);
                }
            } catch (error) {
                alert('Registration failed. Please try again.');
                console.error('Error:', error);
            }
        });
    }

    const adminEditStudentForm = document.getElementById('adminEditStudentForm');
    if (adminEditStudentForm) {
        adminEditStudentForm.addEventListener('submit', async function(e) {
            e.preventDefault();

            const studentID = adminEditStudentForm.dataset.studentId;
            const fullName = document.getElementById('student_fullname').value;
            const username = document.getElementById('student_username').value;
            const email = document.getElementById('student_email').value;
            const password = document.getElementById('student_password').value;
            const stageID = parseInt(document.getElementById('student_stage').value, 10);
            const isDisabled = document.getElementById('student_disabled').checked;

            try {
                const response = await fetch(`/admin/api/student/${studentID}`, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        full_name: fullName,
                        username: username,
                        email: email,
                        password: password,
                        stage_id: stageID,
                        is_disabled: isDisabled
                    })
                });

                if (response.ok) {
                    window.location.href = `/admin/dashboard?student_action=updated&student_name=${encodeURIComponent(fullName)}#students`;
                } else {
                    const error = await response.text();
                    alert('Update failed: ' + error);
                }
            } catch (error) {
                alert('Update failed. Please try again.');
                console.error('Error:', error);
            }
        });
    }

    const personalizedPracticeForm = document.getElementById('personalizedPracticeForm');
    if (personalizedPracticeForm) {
        personalizedPracticeForm.addEventListener('submit', async function(e) {
            e.preventDefault();

            const selectedStudent = document.getElementById('studentSelect').value;
            const checkedQuizInputs = document.querySelectorAll('#quizList input[name="quiz_ids"]:checked');
            const quizIDs = Array.from(checkedQuizInputs).map((input) => parseInt(input.value, 10)).filter(Boolean);
            const title = document.getElementById('personalizedTitle').value.trim();
            const description = document.getElementById('personalizedDescription').value.trim();
            const timeLimitMinutes = parseInt(document.getElementById('personalizedTimeLimit').value, 10) || 0;

            if (!selectedStudent) {
                alert('Please choose a student.');
                return;
            }

            if (quizIDs.length === 0) {
                alert('Please select at least one quiz.');
                return;
            }

            try {
                const response = await fetch('/admin/api/personalized-practice', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        student_id: parseInt(selectedStudent, 10),
                        quiz_ids: quizIDs,
                        title: title,
                        description: description,
                        time_limit_minutes: timeLimitMinutes
                    })
                });

                const result = await response.json().catch(() => ({}));
                if (response.ok) {
                    alert(`Personalized paper created for ${result.student_name || 'the student'}!`);
                    window.location.href = '/admin/dashboard?student_action=personalized-paper&student_name=' + encodeURIComponent(result.student_name || 'Student') + '#students';
                } else {
                    alert(result.error || 'Could not create the personalized paper.');
                }
            } catch (error) {
                console.error(error);
                alert('Could not create the personalized paper.');
            }
        });
    }

    if (window.editQuizID) {
        loadQuizForEdit(window.editQuizID);
    }

    initializeDashboardTabs();
});

function initializeDashboardTabs() {
    const tabs = document.querySelectorAll('[data-dashboard-tab]');
    const panels = document.querySelectorAll('[data-dashboard-panel]');
    if (!tabs.length || !panels.length) {
        return;
    }

    const activateTab = (tabName) => {
        const selectedTabName = tabName || 'quizzes';

        tabs.forEach(tab => {
            const isActive = tab.dataset.dashboardTab === selectedTabName;
            tab.classList.toggle('active', isActive);
            tab.setAttribute('aria-selected', isActive ? 'true' : 'false');
        });

        panels.forEach(panel => {
            panel.classList.toggle('active', panel.dataset.dashboardPanel === selectedTabName);
        });
    };

    tabs.forEach(tab => {
        tab.addEventListener('click', function(e) {
            e.preventDefault();
            const tabName = this.dataset.dashboardTab;
            history.replaceState(null, '', `#${tabName}`);
            activateTab(tabName);
        });
    });

    activateTab(window.location.hash.replace('#', '') || 'quizzes');
}

// Admin - Create Quiz Functions
let questionCount = 0;

function escapeAttribute(value) {
    return String(value || '')
        .replace(/&/g, '&amp;')
        .replace(/"/g, '&quot;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;');
}

function escapeHTML(value) {
    return String(value || '')
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#039;');
}

function revealReportPanel(resultsDiv) {
    resultsDiv.style.display = 'block';
    resultsDiv.scrollIntoView({ behavior: 'smooth', block: 'start' });
}

function initQuestionDiagram(questionNumber, existingDiagram = '') {
    const canvas = document.getElementById(`question_diagram_canvas_${questionNumber}`);
    const diagramInput = document.getElementById(`question_diagram_${questionNumber}`);
    const clearButton = document.getElementById(`clear_diagram_${questionNumber}`);
    const diagramTools = document.getElementById(`diagram_tools_${questionNumber}`);
    const showButton = document.getElementById(`show_diagram_${questionNumber}`);
    if (!canvas || !diagramInput || !clearButton || !diagramTools || !showButton) return;

    const context = canvas.getContext('2d');
    context.lineWidth = 3;
    context.lineCap = 'round';
    context.strokeStyle = '#111827';

    if (existingDiagram) {
        diagramTools.hidden = false;
        showButton.hidden = true;
        const image = new Image();
        image.onload = () => context.drawImage(image, 0, 0, canvas.width, canvas.height);
        image.src = existingDiagram;
        diagramInput.value = existingDiagram;
    }

    let isDrawing = false;

    function getPoint(event) {
        const rect = canvas.getBoundingClientRect();
        return {
            x: (event.clientX - rect.left) * (canvas.width / rect.width),
            y: (event.clientY - rect.top) * (canvas.height / rect.height)
        };
    }

    function saveDiagram() {
        diagramInput.value = canvas.toDataURL('image/png');
    }

    canvas.addEventListener('pointerdown', (event) => {
        event.preventDefault();
        isDrawing = true;
        canvas.setPointerCapture(event.pointerId);
        const point = getPoint(event);
        context.beginPath();
        context.moveTo(point.x, point.y);
    });

    canvas.addEventListener('pointermove', (event) => {
        if (!isDrawing) return;
        event.preventDefault();
        const point = getPoint(event);
        context.lineTo(point.x, point.y);
        context.stroke();
        saveDiagram();
    });

    canvas.addEventListener('pointerup', (event) => {
        if (!isDrawing) return;
        event.preventDefault();
        isDrawing = false;
        saveDiagram();
    });

    canvas.addEventListener('pointercancel', () => {
        isDrawing = false;
    });

    clearButton.addEventListener('click', () => {
        context.clearRect(0, 0, canvas.width, canvas.height);
        diagramInput.value = '';
    });

    showButton.addEventListener('click', () => {
        diagramTools.hidden = false;
        showButton.hidden = true;
    });
}

function initQuestionContext(questionNumber) {
    const contextPanel = document.getElementById(`question_context_panel_${questionNumber}`);
    const contextButton = document.getElementById(`show_context_${questionNumber}`);
    const closeButton = document.getElementById(`close_context_${questionNumber}`);
    if (!contextPanel || !contextButton || !closeButton) return;

    contextButton.addEventListener('click', () => {
        contextPanel.hidden = false;
        contextButton.hidden = true;
    });

    closeButton.addEventListener('click', () => {
        contextPanel.hidden = true;
        contextButton.hidden = false;
    });
}

function initAnswerExplanation(questionNumber) {
    const explanationPanel = document.getElementById(`answer_explanation_panel_${questionNumber}`);
    const explanationButton = document.getElementById(`show_explanation_${questionNumber}`);
    const closeButton = document.getElementById(`close_explanation_${questionNumber}`);
    if (!explanationPanel || !explanationButton || !closeButton) return;

    explanationButton.addEventListener('click', () => {
        explanationPanel.hidden = false;
        explanationButton.hidden = true;
    });

    closeButton.addEventListener('click', () => {
        explanationPanel.hidden = true;
        explanationButton.hidden = false;
    });
}

function addQuestion(question = {}) {
    questionCount++;
    const questionsDiv = document.getElementById('questionsContainer');
    const options = question.options || [];
    const correctIndex = question.correct_answer ? options.indexOf(question.correct_answer) + 1 : 0;
    const questionId = question.id || 0;
    const questionContext = question.question_context || '';
    const questionDiagram = question.question_diagram || '';
    const answerExplanation = question.answer_explanation || '';
    
    const questionDiv = document.createElement('div');
    questionDiv.className = 'question-builder';
    questionDiv.id = `question-${questionCount}`;
    
    questionDiv.innerHTML = `
        <div class="question-builder-header">
            <h3>Question ${questionCount}${questionId ? ` <span class="question-id">#${questionId}</span>` : ''}</h3>
            <button type="button" class="remove-question" onclick="removeQuestion(${questionCount})">Remove</button>
        </div>
        <input type="hidden" name="question_id_${questionCount}" value="${questionId}">

        <button type="button" class="btn btn-secondary btn-small question-support-button" id="show_context_${questionCount}">${questionContext ? 'Edit Context' : 'Add Context'}</button>

        <div class="form-group question-context-panel" id="question_context_panel_${questionCount}" hidden>
            <div class="support-panel-header">
                <label>Context / Details</label>
                <button type="button" class="btn btn-secondary btn-small" id="close_context_${questionCount}">Close</button>
            </div>
            <textarea name="question_context_${questionCount}" rows="6" placeholder="Optional: add a passage, background information, geometry setup, or other details students need before answering">${escapeHTML(questionContext)}</textarea>
        </div>

        <div class="form-group">
            <label>Question Text</label>
            <textarea name="question_text_${questionCount}" rows="3" placeholder="Add the actual question students answer" required>${escapeHTML(question.question_text)}</textarea>
        </div>

        <div class="form-group">
            <input type="hidden" id="question_diagram_${questionCount}" name="question_diagram_${questionCount}" value="${escapeAttribute(questionDiagram)}">
            <button type="button" class="btn btn-secondary btn-small" id="show_diagram_${questionCount}" ${questionDiagram ? 'hidden' : ''}>Add Diagram</button>
            <div class="diagram-tools" id="diagram_tools_${questionCount}" ${questionDiagram ? '' : 'hidden'}>
                <canvas id="question_diagram_canvas_${questionCount}" class="diagram-canvas" width="720" height="360"></canvas>
                <button type="button" class="btn btn-secondary btn-small" id="clear_diagram_${questionCount}">Clear Diagram</button>
            </div>
        </div>
        
        <div class="form-group">
            <label>Option 1</label>
            <input type="text" name="option1_${questionCount}" value="${escapeAttribute(options[0])}" required>
        </div>
        
        <div class="form-group">
            <label>Option 2</label>
            <input type="text" name="option2_${questionCount}" value="${escapeAttribute(options[1])}" required>
        </div>
        
        <div class="form-group">
            <label>Option 3</label>
            <input type="text" name="option3_${questionCount}" value="${escapeAttribute(options[2])}" required>
        </div>
        
        <div class="form-group">
            <label>Option 4</label>
            <input type="text" name="option4_${questionCount}" value="${escapeAttribute(options[3])}" required>
        </div>
        
        <div class="form-group">
            <label>Correct Answer</label>
            <select name="correct_answer_${questionCount}" required>
                <option value="">Select correct option</option>
                <option value="1" ${correctIndex === 1 ? 'selected' : ''}>Option 1</option>
                <option value="2" ${correctIndex === 2 ? 'selected' : ''}>Option 2</option>
                <option value="3" ${correctIndex === 3 ? 'selected' : ''}>Option 3</option>
                <option value="4" ${correctIndex === 4 ? 'selected' : ''}>Option 4</option>
            </select>
        </div>

        <button type="button" class="btn btn-secondary btn-small question-support-button" id="show_explanation_${questionCount}">${answerExplanation ? 'Edit Explanation' : 'Add Explanation'}</button>

        <div class="form-group question-explanation-panel" id="answer_explanation_panel_${questionCount}" hidden>
            <div class="support-panel-header">
                <label>Answer Explanation</label>
                <button type="button" class="btn btn-secondary btn-small" id="close_explanation_${questionCount}">Close</button>
            </div>
            <textarea name="answer_explanation_${questionCount}" rows="8" placeholder="Optional: add multi-line calculations, working steps, or reasoning shown only on the mistakes report">${escapeHTML(answerExplanation)}</textarea>
        </div>
        
        <div class="form-group">
            <label>Points</label>
            <input type="number" name="points_${questionCount}" value="${question.points || 1}" min="1" required>
        </div>
    `;
    
    questionsDiv.appendChild(questionDiv);
    initQuestionContext(questionCount);
    initQuestionDiagram(questionCount, questionDiagram);
    initAnswerExplanation(questionCount);
}

function removeQuestion(id) {
    const questionDiv = document.getElementById(`question-${id}`);
    if (questionDiv) {
        questionDiv.remove();
    }
}

// Submit Quiz Creation
async function submitQuiz(event, quizId = null) {
    event.preventDefault();
    
    const form = event.target;
    const formData = new FormData(form);
    
    const title = formData.get('quiz_title');
    const description = formData.get('quiz_description');
    const stageID = parseInt(formData.get('stage_id'), 10);
    const timeLimitMinutes = parseInt(formData.get('time_limit_minutes') || '0', 10);
    const lockAfterAttempt = formData.get('do_not_lock_after_attempt') !== 'on';
    
    const questions = [];
    for (let i = 1; i <= questionCount; i++) {
        const questionDiv = document.getElementById(`question-${i}`);
        if (!questionDiv) continue;
        
        const questionId = parseInt(formData.get(`question_id_${i}`) || '0');
        const questionContext = formData.get(`question_context_${i}`) || '';
        const questionText = formData.get(`question_text_${i}`);
        const questionDiagram = formData.get(`question_diagram_${i}`) || '';
        const answerExplanation = formData.get(`answer_explanation_${i}`) || '';
        const option1 = formData.get(`option1_${i}`);
        const option2 = formData.get(`option2_${i}`);
        const option3 = formData.get(`option3_${i}`);
        const option4 = formData.get(`option4_${i}`);
        const correctAnswerIndex = formData.get(`correct_answer_${i}`);
        const points = parseInt(formData.get(`points_${i}`));
        
        const options = [option1, option2, option3, option4];
        const correctAnswer = options[parseInt(correctAnswerIndex) - 1];
        
        questions.push({
            id: questionId,
            question_context: questionContext,
            question_text: questionText,
            question_diagram: questionDiagram,
            answer_explanation: answerExplanation,
            question_type: 'meaning',
            correct_answer: correctAnswer,
            options: options,
            points: points
        });
    }
    
    if (questions.length === 0) {
        alert('Please add at least one question!');
        return;
    }
    
    try {
        const url = quizId ? `/admin/api/quiz/${quizId}` : '/admin/api/quiz/create';
        const method = quizId ? 'PUT' : 'POST';
        const response = await fetch(url, {
            method: method,
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                title: title,
                description: description,
                stage_id: stageID,
                time_limit_minutes: Number.isNaN(timeLimitMinutes) ? 0 : timeLimitMinutes,
                lock_after_attempt: lockAfterAttempt,
                questions: questions
            })
        });
        
        if (response.ok) {
            alert(quizId ? 'Quiz updated successfully!' : 'Quiz created successfully!');
            window.location.href = '/admin/dashboard';
        } else {
            const error = await response.text();
            alert(`Failed to ${quizId ? 'update' : 'create'} quiz: ` + error);
        }
    } catch (error) {
        alert(`Failed to ${quizId ? 'update' : 'create'} quiz. Please try again.`);
        console.error('Error:', error);
    }
}

async function loadQuizForEdit(quizId) {
    try {
        const response = await fetch(`/admin/api/quiz/${quizId}`);
        if (!response.ok) {
            const error = await response.text();
            alert('Failed to load quiz: ' + error);
            window.location.href = '/admin/dashboard';
            return;
        }

        const data = await response.json();
        const form = document.getElementById('editQuizForm');
        form.elements.quiz_title.value = data.quiz.title || '';
        form.elements.quiz_description.value = data.quiz.description || '';
        form.elements.stage_id.value = data.quiz.stage_id || '';
        form.elements.time_limit_minutes.value = data.quiz.time_limit_minutes || 0;
        form.elements.do_not_lock_after_attempt.checked = !Boolean(data.quiz.lock_after_attempt);

        const questionsDiv = document.getElementById('questionsContainer');
        questionsDiv.innerHTML = '';
        questionCount = 0;

        (data.questions || []).forEach(question => addQuestion(question));
    } catch (error) {
        console.error('Error loading quiz:', error);
        alert('Failed to load quiz');
        window.location.href = '/admin/dashboard';
    }
}

// Load Quiz Results
async function loadResults(quizId) {
    const resultsDiv = document.getElementById('resultsContainer');
    if (!resultsDiv) {
        alert('Results area is missing on this page.');
        return;
    }

    resultsDiv.innerHTML = '<h2>Student Results</h2><p>Loading results...</p>';
    revealReportPanel(resultsDiv);

    try {
        const response = await fetch(`/admin/api/quiz/${quizId}/results`);
        if (!response.ok) {
            const error = await response.text();
            resultsDiv.innerHTML = '<h2>Student Results</h2><p>Could not load results.</p>';
            alert('Failed to load results: ' + error);
            return;
        }

        const results = await response.json();
        resultsDiv.innerHTML = '<h2>Student Results</h2>';
        
        if (!Array.isArray(results) || results.length === 0) {
            resultsDiv.innerHTML += '<p>No students have taken this quiz yet.</p>';
            revealReportPanel(resultsDiv);
            return;
        }
        
        let tableHTML = `
            <table class="results-table">
                <thead>
                    <tr>
                        <th>Student Name</th>
                        <th>Username</th>
                        <th>Score</th>
                        <th>Percentage</th>
                        <th>Completed At</th>
                        <th>Report</th>
                        <th>Mistakes</th>
                    </tr>
                </thead>
                <tbody>
        `;
        
        results.forEach(result => {
            const percentage = Number(result.percentage || 0);
            const reportURL = result.report_pdf_url || `/admin/attempt/${result.attempt_id}/report.pdf`;
            const mistakesURL = result.mistakes_pdf_url || `/admin/attempt/${result.attempt_id}/mistakes.pdf`;
            tableHTML += `
                <tr>
                    <td>${escapeHTML(result.full_name)}</td>
                    <td>${escapeHTML(result.username)}</td>
                    <td>${result.score}/${result.max_score}</td>
                    <td>${percentage.toFixed(1)}%</td>
                    <td>${escapeHTML(new Date(result.completed_at).toLocaleString())}</td>
                    <td><a class="btn btn-secondary btn-small" href="${escapeAttribute(reportURL)}" target="_blank" rel="noopener">PDF</a></td>
                    <td><a class="btn btn-primary btn-small" href="${escapeAttribute(mistakesURL)}" target="_blank" rel="noopener">Mistakes</a></td>
                </tr>
            `;
        });
        
        tableHTML += '</tbody></table>';
        resultsDiv.innerHTML += tableHTML;
        revealReportPanel(resultsDiv);
        
    } catch (error) {
        console.error('Error loading results:', error);
        resultsDiv.innerHTML = '<h2>Student Results</h2><p>Could not load results.</p>';
        alert('Failed to load results');
    }
}

async function loadProgressReport(quizId) {
    const resultsDiv = document.getElementById('resultsContainer');
    if (!resultsDiv) {
        alert('Results area is missing on this page.');
        return;
    }

    resultsDiv.innerHTML = '<h2>Progress Report</h2><p>Loading progress report...</p>';
    revealReportPanel(resultsDiv);

    try {
        const response = await fetch(`/admin/api/quiz/${quizId}/progress`);
        if (!response.ok) {
            const error = await response.text();
            resultsDiv.innerHTML = '<h2>Progress Report</h2><p>Could not load progress report.</p>';
            alert('Failed to load progress report: ' + error);
            return;
        }

        const reports = await response.json();
        resultsDiv.innerHTML = '<h2>Progress Report</h2>';

        if (!Array.isArray(reports) || reports.length === 0) {
            resultsDiv.innerHTML += '<p>No students have taken this quiz yet.</p>';
            revealReportPanel(resultsDiv);
            return;
        }

        let tableHTML = `
            <table class="results-table progress-table">
                <thead>
                    <tr>
                        <th>Student</th>
                        <th>Attempts</th>
                        <th>First</th>
                        <th>Latest</th>
                        <th>Best</th>
                        <th>Change</th>
                        <th>Attempt History</th>
                    </tr>
                </thead>
                <tbody>
        `;

        reports.forEach(report => {
            const changeClass = report.improvement >= 0 ? 'progress-up' : 'progress-down';
            const changePrefix = report.improvement > 0 ? '+' : '';
            const history = report.attempts.map((attempt, index) => {
                const reportURL = attempt.report_pdf_url || `/admin/attempt/${attempt.attempt_id}/report.pdf`;
                const mistakesURL = attempt.mistakes_pdf_url || `/admin/attempt/${attempt.attempt_id}/mistakes.pdf`;
                return `<span class="attempt-review-group"><a class="attempt-pill" href="${escapeAttribute(reportURL)}" target="_blank" rel="noopener">#${index + 1}: ${attempt.score}/${attempt.max_score} (${attempt.percentage.toFixed(1)}%)</a><a class="attempt-pill attempt-pill-primary" href="${escapeAttribute(mistakesURL)}" target="_blank" rel="noopener">Mistakes</a></span>`;
            }).join('');

            tableHTML += `
                <tr>
                    <td>${escapeHTML(report.full_name)}<br><span class="quiz-date">${escapeHTML(report.username)}</span></td>
                    <td>${report.attempt_count}</td>
                    <td>${report.first_percentage.toFixed(1)}%</td>
                    <td>${report.latest_percentage.toFixed(1)}%</td>
                    <td>${report.best_percentage.toFixed(1)}%</td>
                    <td class="${changeClass}">${changePrefix}${report.improvement.toFixed(1)}%</td>
                    <td><div class="attempt-history">${history}</div></td>
                </tr>
            `;
        });

        tableHTML += '</tbody></table>';
        resultsDiv.innerHTML += tableHTML;
        revealReportPanel(resultsDiv);
    } catch (error) {
        console.error('Error loading progress report:', error);
        resultsDiv.innerHTML = '<h2>Progress Report</h2><p>Could not load progress report.</p>';
        alert('Failed to load progress report');
    }
}

async function resetQuiz(quizId) {
    if (!confirm('Unlock this exam for another attempt? Existing attempts will stay in the progress report.')) {
        return;
    }

    try {
        const response = await fetch(`/admin/api/quiz/${quizId}/reset`, {
            method: 'POST'
        });

        if (!response.ok) {
            const error = await response.text();
            alert('Failed to unlock exam: ' + error);
            return;
        }

        const result = await response.json();
        alert(`Exam unlocked. Unlock version: ${result.unlock_version}`);
        loadProgressReport(quizId);
    } catch (error) {
        console.error('Error unlocking exam:', error);
        alert('Failed to unlock exam');
    }
}

async function archiveQuiz(quizId) {
    if (!confirm('Archive this exam? Archived exams are hidden from students.')) {
        return;
    }

    try {
        const response = await fetch(`/admin/api/quiz/${quizId}/archive`, {
            method: 'POST'
        });

        if (!response.ok) {
            const error = await response.text();
            alert('Failed to archive exam: ' + error);
            return;
        }

        alert('Exam archived successfully.');
        window.location.reload();
    } catch (error) {
        console.error('Error archiving exam:', error);
        alert('Failed to archive exam');
    }
}

async function unarchiveQuiz(quizId) {
    if (!confirm('Restore this archived exam to live status?')) {
        return;
    }

    try {
        const response = await fetch(`/admin/api/quiz/${quizId}/unarchive`, {
            method: 'POST'
        });

        if (!response.ok) {
            const error = await response.text();
            alert('Failed to restore exam: ' + error);
            return;
        }

        alert('Exam restored successfully.');
        window.location.reload();
    } catch (error) {
        console.error('Error restoring exam:', error);
        alert('Failed to restore exam');
    }
}

async function setStudentDisabled(studentId, studentName, action) {
    const actionLabel = action === 'disable' ? 'disable' : 'enable';
    const resultLabel = action === 'disable' ? 'disabled' : 'enabled';
    const confirmMessage = action === 'disable'
        ? `Disable ${studentName}? They will not be able to log in or continue using the app.`
        : `Enable ${studentName}? They will be able to log in again.`;

    if (!confirm(confirmMessage)) {
        return;
    }

    try {
        const response = await fetch(`/admin/api/student/${studentId}/${actionLabel}`, {
            method: 'POST'
        });

        if (!response.ok) {
            const error = await response.text();
            alert(`Failed to ${actionLabel} student: ` + error);
            return;
        }

        window.location.href = `/admin/dashboard?student_action=${resultLabel}&student_name=${encodeURIComponent(studentName)}#students`;
    } catch (error) {
        console.error(`Error trying to ${actionLabel} student:`, error);
        alert(`Failed to ${actionLabel} student`);
    }
}

function disableStudent(studentId, studentName) {
    setStudentDisabled(studentId, studentName, 'disable');
}

function enableStudent(studentId, studentName) {
    setStudentDisabled(studentId, studentName, 'enable');
}

async function deleteStudent(studentId, studentName) {
    if (!confirm(`Delete ${studentName} permanently? Their attempts and answers will also be removed.`)) {
        return;
    }

    try {
        const response = await fetch(`/admin/api/student/${studentId}`, {
            method: 'DELETE'
        });

        if (!response.ok) {
            const error = await response.text();
            alert('Failed to delete student: ' + error);
            return;
        }

        window.location.href = `/admin/dashboard?student_action=deleted&student_name=${encodeURIComponent(studentName)}#students`;
    } catch (error) {
        console.error('Error deleting student:', error);
        alert('Failed to delete student');
    }
}

async function deleteQuiz(quizId) {
    if (!confirm('Delete this exam permanently? This action cannot be undone.')) {
        return;
    }

    try {
        const response = await fetch(`/admin/api/quiz/${quizId}`, {
            method: 'DELETE'
        });

        if (!response.ok) {
            const error = await response.text();
            alert('Failed to delete exam: ' + error);
            return;
        }

        alert('Exam deleted successfully.');
        window.location.reload();
    } catch (error) {
        console.error('Error deleting exam:', error);
        alert('Failed to delete exam');
    }
}
