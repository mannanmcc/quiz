#!/bin/bash

echo "🎓 Vocabulary Quiz Application Setup"
echo "===================================="

# Check if Go is installed
if ! command -v go &> /dev/null
then
    echo "❌ Go is not installed. Please install Go 1.19 or higher."
    exit 1
fi

echo "✅ Go is installed: $(go version)"

# Initialize Go module
echo ""
echo "📦 Initializing Go modules..."
go mod init vocabulary-quiz-app 2>/dev/null || echo "Module already initialized"

# Download dependencies
echo ""
echo "📥 Downloading dependencies..."
go get github.com/gorilla/mux
go get github.com/gorilla/sessions
go get github.com/mattn/go-sqlite3
go get golang.org/x/crypto/bcrypt

# Tidy up dependencies
go mod tidy

# Build the application
echo ""
echo "🔨 Building application..."
go build -o quiz-app ./cmd/server

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Build successful!"
    echo ""
    echo "🚀 To start the application, run:"
    echo "   ./quiz-app"
    echo ""
    echo "   Then open http://localhost:8080 in your browser"
    echo ""
    echo "📝 Default admin credentials:"
    echo "   Username: admin"
    echo "   Password: admin123"
else
    echo "❌ Build failed. Please check the errors above."
    exit 1
fi
