# CLAUDE.md

This file provides guidance to Claude Code when working with this Hospital Management System (HSC1) repository.

## Project Overview

HSC1 is a comprehensive hospital management system built with Ruby on Rails. It features a microservices architecture with separate backend API and frontend applications.

## Architecture

- **Backend** (`/backend/`): Rails 8.0.0 API server (port 7001)
  - JWT-based authentication
  - PostgreSQL database
  - RESTful API endpoints
  - Swagger/OpenAPI documentation

- **Frontend** (`/frontend/`): Rails 8.0.0 web application (port 7002)
  - Hotwire (Turbo + Stimulus)
  - Tailwind CSS styling
  - Client-side JWT authentication

## Development Commands

### Backend (API Server)
```bash
cd backend

# Setup
bundle install
rails db:create db:migrate db:seed

# Development
rails server -p 7001

# Testing
bundle exec rspec
```

### Frontend (Web App)
```bash
cd frontend

# Setup
bundle install
npm install
npm run build:css

# Development
rails server -p 7002
```

### Docker Alternative
```bash
# Start all services
docker-compose up -d

# Individual services
docker-compose up backend
docker-compose up frontend
```

## Code Conventions

### Ruby/Rails
- Follow standard Rails conventions
- Use snake_case for variables and methods
- Use PascalCase for classes and modules
- Prefer explicit over implicit returns
- Use strong parameters in controllers
- Implement proper error handling

### JavaScript
- ES6+ features preferred
- Use modules for organization
- Follow async/await patterns
- Implement proper error handling
- Use descriptive variable names

### Database
- Use descriptive table and column names
- Implement proper indexes
- Use foreign key constraints
- Follow Rails naming conventions

## Authentication System

The system uses JWT-based authentication with the following roles:
- `0`: read_only
- `1`: staff  
- `2`: manager
- `3`: admin

Default development account:
- Email: admin@hospital.com
- Password: password123
- Role: admin (3)

## Testing

The project has comprehensive test coverage with 57 test cases:
- RSpec for backend testing
- FactoryBot for test data generation
- Integration tests for API endpoints
- System tests for frontend workflows

Run tests with:
```bash
cd backend
bundle exec rspec
```

## API Documentation

Swagger/OpenAPI documentation is available at:
- Development: http://localhost:7001/api-docs
- JSON Schema: http://localhost:7001/api/v1/swagger.json

## Database Schema

Key models include:
- User (authentication)
- Employee (staff management)
- Patient (patient records)
- Appointment (scheduling)
- Document (electronic approval)
- LeaveRequest (vacation management)
- Attendance (time tracking)
- Payroll (salary management)

## Important Files

- `backend/config/routes.rb`: API routing configuration
- `frontend/config/routes.rb`: Web app routing
- `backend/app/controllers/application_controller.rb`: Base API controller with JWT auth
- `frontend/app/assets/javascripts/modules/auth.js`: Client-side auth manager
- `docker-compose.yml`: Container orchestration
- `backend/swagger/v1/swagger.yaml`: API documentation schema

## Security Considerations

- JWT tokens stored in localStorage
- CORS configured for cross-origin requests
- Strong parameter validation
- SQL injection prevention
- XSS protection enabled
- CSRF tokens for state-changing operations

## Development Workflow

1. Make changes to relevant files
2. Run tests to ensure functionality
3. Update API documentation if needed
4. Test in both development servers
5. Commit changes with descriptive messages

## Common Tasks

### Adding New API Endpoints
1. Add route in `backend/config/routes.rb`
2. Create controller action
3. Add tests in `backend/spec/`
4. Update Swagger documentation
5. Test with frontend integration

### Adding Frontend Pages
1. Add route in `frontend/config/routes.rb`
2. Create controller and view
3. Add authentication checks
4. Style with Tailwind CSS
5. Add JavaScript interactions if needed

### Database Changes
1. Generate migration: `rails generate migration`
2. Update model validations and associations
3. Update factories and tests
4. Run migration in both environments

## Troubleshooting

- Check server logs in `log/development.log`
- Verify JWT token in browser localStorage
- Ensure both servers are running on correct ports
- Check database connection and migrations
- Verify CORS configuration for API calls

## Performance Considerations

- Use database indexes appropriately
- Implement pagination for large datasets
- Optimize N+1 queries with includes
- Use caching where appropriate
- Monitor API response times