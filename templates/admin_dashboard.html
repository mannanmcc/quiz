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
});

// Admin - Create Quiz Functions
let questionCount = 0;

function addQuestion() {
    questionCount++;
    const questionsDiv = document.getElementById('questionsContainer');
    
    const questionDiv = document.createElement('div');
    questionDiv.className = 'question-builder';
    questionDiv.id = `question-${questionCount}`;
    
    questionDiv.innerHTML = `
        <div class="question-builder-header">
            <h3>Question ${questionCount}</h3>
            <button type="button" class="remove-question" onclick="removeQuestion(${questionCount})">Remove</button>
        </div>
        
        <div class="form-group">
            <label>Question Type</label>
            <select name="question_type_${questionCount}" required>
                <option value="meaning">Word Meaning</option>
                <option value="synonym">Synonym</option>
                <option value="antonym">Antonym</option>
            </select>
        </div>
        
        <div class="form-group">
            <label>Question Text</label>
            <input type="text" name="question_text_${questionCount}" placeholder="e.g., What is the meaning of 'Happy'?" required>
        </div>
        
        <div class="form-group">
            <label>Option 1</label>
            <input type="text" name="option1_${questionCount}" required>
        </div>
        
        <div class="form-group">
            <label>Option 2</label>
            <input type="text" name="option2_${questionCount}" required>
        </div>
        
        <div class="form-group">
            <label>Option 3</label>
            <input type="text" name="option3_${questionCount}" required>
        </div>
        
        <div class="form-group">
            <label>Option 4</label>
            <input type="text" name="option4_${questionCount}" required>
        </div>
        
        <div class="form-group">
            <label>Correct Answer</label>
            <select name="correct_answer_${questionCount}" required>
                <option value="">Select correct option</option>
                <option value="1">Option 1</option>
                <option value="2">Option 2</option>
                <option value="3">Option 3</option>
                <option value="4">Option 4</option>
            </select>
        </div>
        
        <div class="form-group">
            <label>Points</label>
            <input type="number" name="points_${questionCount}" value="1" min="1" required>
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
async function submitQuiz(event) {
    event.preventDefault();
    
    const form = event.target;
    const formData = new FormData(form);
    
    const title = formData.get('quiz_title');
    const description = formData.get('quiz_description');
    
    const questions = [];
    for (let i = 1; i <= questionCount; i++) {
        const questionDiv = document.getElementById(`question-${i}`);
        if (!questionDiv) continue;
        
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
        const response = await fetch('/admin/api/quiz/create', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                title: title,
                description: description,
                questions: questions
            })
        });
        
        if (response.ok) {
            alert('Quiz created successfully!');
            window.location.href = '/admin/dashboard';
        } else {
            const error = await response.text();
            alert('Failed to create quiz: ' + error);
        }
    } catch (error) {
        alert('Failed to create quiz. Please try again.');
        console.error('Error:', error);
    }
}

// Load Quiz Results
async function loadResults(quizId) {
    try {
        const response = await fetch(`/admin/api/quiz/${quizId}/results`);
        const results = await response.json();
        
        const resultsDiv = document.getElementById('resultsContainer');
        resultsDiv.innerHTML = '<h2>Student Results</h2>';
        
        if (results.length === 0) {
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
                    <td>${result.full_name}</td>
                    <td>${result.username}</td>
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