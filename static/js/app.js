// Login/Register Toggle
document.addEventListener('DOMContentLoaded', function() {
    const showRegister = document.getElementById('showRegister');
    const cancelRegister = document.getElementById('cancelRegister');
    const registerBox = document.getElementById('registerBox');
    const loginBox = document.querySelector('.login-box');
    const registerForm = document.getElementById('registerForm');

    if (showRegister) {
        showRegister.addEventListener('click', function(e) {
            e.preventDefault();
            loginBox.style.display = 'none';
            registerBox.style.display = 'block';
        });
    }

    if (cancelRegister) {
        cancelRegister.addEventListener('click', function() {
            registerBox.style.display = 'none';
            loginBox.style.display = 'block';
        });
    }

    if (registerForm) {
        registerForm.addEventListener('submit', async function(e) {
            e.preventDefault();
            
            const fullName = document.getElementById('reg_fullname').value;
            const username = document.getElementById('reg_username').value;
            const password = document.getElementById('reg_password').value;

            try {
                const response = await fetch('/api/register', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        full_name: fullName,
                        username: username,
                        password: password
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

    if (window.editQuizID) {
        loadQuizForEdit(window.editQuizID);
    }
});

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

function addQuestion(question = {}) {
    questionCount++;
    const questionsDiv = document.getElementById('questionsContainer');
    const options = question.options || [];
    const correctIndex = question.correct_answer ? options.indexOf(question.correct_answer) + 1 : 0;
    const questionType = question.question_type || 'meaning';
    const questionId = question.id || 0;
    
    const questionDiv = document.createElement('div');
    questionDiv.className = 'question-builder';
    questionDiv.id = `question-${questionCount}`;
    
    questionDiv.innerHTML = `
        <div class="question-builder-header">
            <h3>Question ${questionCount}${questionId ? ` <span class="question-id">#${questionId}</span>` : ''}</h3>
            <button type="button" class="remove-question" onclick="removeQuestion(${questionCount})">Remove</button>
        </div>
        <input type="hidden" name="question_id_${questionCount}" value="${questionId}">
        
        <div class="form-group">
            <label>Question Type</label>
            <select name="question_type_${questionCount}" required>
                <option value="meaning" ${questionType === 'meaning' ? 'selected' : ''}>Word Meaning</option>
                <option value="synonym" ${questionType === 'synonym' ? 'selected' : ''}>Synonym</option>
                <option value="antonym" ${questionType === 'antonym' ? 'selected' : ''}>Antonym</option>
            </select>
        </div>
        
        <div class="form-group">
            <label>Question Text</label>
            <input type="text" name="question_text_${questionCount}" value="${escapeAttribute(question.question_text)}" placeholder="e.g., What is the meaning of 'Happy'?" required>
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
        
        <div class="form-group">
            <label>Points</label>
            <input type="number" name="points_${questionCount}" value="${question.points || 1}" min="1" required>
        </div>
    `;
    
    questionsDiv.appendChild(questionDiv);
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
    const lockAfterAttempt = formData.get('do_not_lock_after_attempt') !== 'on';
    
    const questions = [];
    for (let i = 1; i <= questionCount; i++) {
        const questionDiv = document.getElementById(`question-${i}`);
        if (!questionDiv) continue;
        
        const questionId = parseInt(formData.get(`question_id_${i}`) || '0');
        const questionType = formData.get(`question_type_${i}`);
        const questionText = formData.get(`question_text_${i}`);
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
            question_text: questionText,
            question_type: questionType,
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
    try {
        const response = await fetch(`/admin/api/quiz/${quizId}/results`);
        if (!response.ok) {
            const error = await response.text();
            alert('Failed to load results: ' + error);
            return;
        }

        const results = await response.json();
        
        const resultsDiv = document.getElementById('resultsContainer');
        resultsDiv.innerHTML = '<h2>Student Results</h2>';
        
        if (!Array.isArray(results) || results.length === 0) {
            resultsDiv.innerHTML += '<p>No students have taken this quiz yet.</p>';
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
                    </tr>
                </thead>
                <tbody>
        `;
        
        results.forEach(result => {
            tableHTML += `
                <tr>
                    <td>${escapeHTML(result.full_name)}</td>
                    <td>${escapeHTML(result.username)}</td>
                    <td>${result.score}/${result.max_score}</td>
                    <td>${result.percentage.toFixed(1)}%</td>
                    <td>${new Date(result.completed_at).toLocaleString()}</td>
                </tr>
            `;
        });
        
        tableHTML += '</tbody></table>';
        resultsDiv.innerHTML += tableHTML;
        
    } catch (error) {
        console.error('Error loading results:', error);
        alert('Failed to load results');
    }
}

async function loadProgressReport(quizId) {
    try {
        const response = await fetch(`/admin/api/quiz/${quizId}/progress`);
        if (!response.ok) {
            const error = await response.text();
            alert('Failed to load progress report: ' + error);
            return;
        }

        const reports = await response.json();
        const resultsDiv = document.getElementById('resultsContainer');
        resultsDiv.innerHTML = '<h2>Progress Report</h2>';

        if (!Array.isArray(reports) || reports.length === 0) {
            resultsDiv.innerHTML += '<p>No students have taken this quiz yet.</p>';
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
                return `<span class="attempt-pill">#${index + 1}: ${attempt.score}/${attempt.max_score} (${attempt.percentage.toFixed(1)}%)</span>`;
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
    } catch (error) {
        console.error('Error loading progress report:', error);
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
