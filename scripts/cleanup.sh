#!/bin/bash
# =============================================================================
# Cleanup Script for Data Centralization Platform
# =============================================================================

set -e

echo "🧹 Cleaning up Data Centralization Platform..."

# Stop and remove containers
echo "🛑 Stopping Docker services..."
docker-compose down

# Remove volumes (optional - commented out for safety)
# echo "🗑️  Removing Docker volumes..."
# docker-compose down -v

# Clean Python cache
echo "🐍 Cleaning Python cache..."
find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
find . -type f -name "*.pyc" -delete 2>/dev/null || true
find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true

# Clean logs (optional - commented out for safety)
# echo "📝 Cleaning logs..."
# rm -rf logs/* tmp/*

echo "✅ Cleanup complete!"
echo ""
echo "⚠️  Note: Data volumes are preserved. To remove them, run:"
echo "    docker-compose down -v"
