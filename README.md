# RaceDay - Race Event Management System

## System Description
RaceDay is a web-based race event management system that allows Organisers to create and manage race events, and Participants to browse and enrol in those events. The system handles everything from event creation and category management to participant enrolments and race results.

## Roles

### Organiser
- Register and log in to the system
- Create, update and delete race events
- Manage race categories
- View all enrolments for their events
- Capture and update race results for participants

### Participant
- Register and log in to the system
- Browse all upcoming race events
- Enrol in events
- View their own enrolments
- View their personal race results history

## Database Entities

| Entity | Purpose |
|---|---|
| Users | Stores both Organisers and Participants distinguished by a Role field |
| Events | Events created and managed by Organisers |
| Categories | Race categories e.g. Road Running, Cycling, Walking |
| Event_Categories | Links events to multiple categories |
| Enrolments | Records of participants signing up to events |
| Results | Race results tied to each enrolment |

## Database Relationships
- A User (Organiser) can organise many Events
- A User (Participant) can enrol in many Events
- An Event can have many Enrolments
- An Event can belong to many Categories through Event_Categories
- An Enrolment produces one Result

## Project Structure
```
/docs
  - RaceDay_SQL_Script.sql   (Full database script)
  - RaceDay_API_Endpoints.txt (Full API endpoint plan)
  - RaceDay_ERD.png          (Entity Relationship Diagram)
  - ci-screenshot.png        (CI/CD green build screenshot)
```

## SQL Script
The SQL script creates the full RaceDay database including all tables, relationships, constraints and sample seed data. It can be found in /docs/RaceDay_SQL_Script.sql

## API Endpoint Plan
The full API endpoint plan covering all routes, methods, roles, request bodies and expected responses can be found in /docs/RaceDay_API_Endpoints.txt

## CI/CD
![CI/CD Build](docs/ci-screenshot.png)

## Video Presentation
[RaceDay System Walkthrough](YOUR_YOUTUBE_LINK_HERE)
