#!/bin/bash
# =============================================================================
# Setup Script for Data Centralization Platform
# =============================================================================

set -e

echo "🚀 Setting up Data Centralization Platform..."

# Check if .env exists
if [ ! -f .env ]; then
    echo "📝 Creating .env file from .env.example..."
    cp .env.example .env
    echo "✅ .env file created. Please update with your configuration."
else
    echo "✅ .env file already exists"
fi

# Create necessary directories
echo "📁 Creating directories..."
mkdir -p logs data tmp data/raw data/processed data/archive

# Check Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

echo "✅ Docker and Docker Compose are installed"

# Pull Docker images
echo "📦 Pulling Docker images..."
docker-compose pull

# Start services
echo "🐳 Starting Docker services..."
docker-compose up -d

# Wait for services to be ready
echo "⏳ Waiting for services to be ready..."
sleep 10

# Check service health
echo "🔍 Checking service health..."
docker-compose ps

echo ""
echo "✅ Setup complete!"
echo ""
echo "📊 Service URLs:"
echo "  - PostgreSQL:        localhost:5432"
echo "  - PgAdmin:           http://localhost:5050 (admin@dfp.local / admin123)"
echo "  - Redis:             localhost:6379"
echo "  - MinIO Console:     http://localhost:9001 (minioadmin / minioadmin123)"
echo "  - RabbitMQ Console:  http://localhost:15672 (rabbitmq / rabbitmq123)"
echo ""
echo "🎯 Next steps:"
echo "  1. Review and update .env file"
echo "  2. Install Python dependencies: pip install -e '.[dev]'"
echo "  3. Run migrations: python scripts/migrate.py"
echo "  4. Start API server: uvicorn src.api.main:app --reload"
echo ""
