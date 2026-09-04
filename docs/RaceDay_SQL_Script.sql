-- ============================================
-- RaceDay Database Script
-- Part 1 - System Planning and Database
-- ============================================

-- Create the database
CREATE DATABASE RaceDay1;
GO

USE RaceDay1;
GO

-- ============================================
-- TABLE: Users
-- Stores both Organisers and Participants
-- ============================================

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL CHECK (Role IN ('Organiser', 'Participant')),
    PhoneNumber VARCHAR(20) NULL,
    DateRegistered DATE NOT NULL DEFAULT GETDATE()
);
GO

-- ============================================
-- TABLE: Categories
-- Event categories e.g. Road Running, Cycling
-- ============================================

CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL UNIQUE,
    Description VARCHAR(255) NULL
);
GO

-- ============================================
-- TABLE: Events
-- Events created and managed by Organisers
-- ============================================

CREATE TABLE Events (
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    OrganizerID INT NOT NULL,
    CategoryID INT NOT NULL,
    EventName VARCHAR(150) NOT NULL,
    EventDate DATE NOT NULL,
    Location VARCHAR(150) NOT NULL,
    RouteDescription VARCHAR(500) NULL,
    Distance VARCHAR(50) NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Upcoming' CHECK (Status IN ('Upcoming', 'Ongoing', 'Completed', 'Cancelled')),
    MaxParticipants INT NOT NULL DEFAULT 100,
    CONSTRAINT FK_Events_Organizer FOREIGN KEY (OrganizerID) REFERENCES Users(UserID),
    CONSTRAINT FK_Events_Category FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
GO

-- ============================================
-- TABLE: Event_Categories
-- Links events to multiple categories
-- ============================================

CREATE TABLE Event_Categories (
    EventCategoryID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    CategoryID INT NOT NULL,
    CONSTRAINT FK_EventCategories_Event FOREIGN KEY (EventID) REFERENCES Events(EventID),
    CONSTRAINT FK_EventCategories_Category FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    CONSTRAINT UQ_EventCategory UNIQUE (EventID, CategoryID)
);
GO

-- ============================================
-- TABLE: Enrolments
-- Participants signing up to events
-- ============================================

CREATE TABLE Enrolments (
    EnrolmentID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    EventID INT NOT NULL,
    EnrolmentDate DATE NOT NULL DEFAULT GETDATE(),
    Status VARCHAR(20) NOT NULL DEFAULT 'Confirmed' CHECK (Status IN ('Confirmed', 'Cancelled', 'Completed')),
    CONSTRAINT FK_Enrolments_User FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CONSTRAINT FK_Enrolments_Event FOREIGN KEY (EventID) REFERENCES Events(EventID),
    CONSTRAINT UQ_UserEvent UNIQUE (UserID, EventID)
);
GO

-- ============================================
-- TABLE: Results
-- Race results linked to enrolments
-- ============================================

CREATE TABLE Results (
    ResultID INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentID INT NOT NULL UNIQUE,
    FinishTime VARCHAR(20) NOT NULL,
    PositionOverall INT NULL,
    PositionCategory INT NULL,
    Notes VARCHAR(500) NULL,
    CONSTRAINT FK_Results_Enrolment FOREIGN KEY (EnrolmentID) REFERENCES Enrolments(EnrolmentID)
);
GO

-- ============================================
-- SEED DATA: Users (2 Organisers, 2 Participants)
-- ============================================

INSERT INTO Users (FirstName, LastName, Email, PasswordHash, Role, PhoneNumber, DateRegistered)
VALUES
('Thabo', 'Nkosi', 'thabo.nkosi@raceday.co.za', 'hashed_password_1', 'Organiser', '0821234567', '2024-01-10'),
('Lerato', 'Dlamini', 'lerato.dlamini@raceday.co.za', 'hashed_password_2', 'Organiser', '0839876543', '2024-01-12'),
('Sipho', 'Mokoena', 'sipho.mokoena@gmail.com', 'hashed_password_3', 'Participant', '0761112233', '2024-02-01'),
('Zanele', 'Khumalo', 'zanele.khumalo@gmail.com', 'hashed_password_4', 'Participant', '0724445566', '2024-02-03');
GO

-- ============================================
-- SEED DATA: Categories
-- ============================================

INSERT INTO Categories (CategoryName, Description)
VALUES
('Road Running', 'Running events held on paved roads'),
('Cycling', 'Road and trail cycling events'),
('Walking', 'Community walks and charity walk events'),
('Trail Running', 'Off-road running events on natural terrain'),
('Triathlon', 'Multi-discipline events combining swim, bike, and run');
GO

-- ============================================
-- SEED DATA: Events (3 Events)
-- ============================================

INSERT INTO Events (OrganizerID, CategoryID, EventName, EventDate, Location, RouteDescription, Distance, Status, MaxParticipants)
VALUES
(1, 1, 'Soweto Marathon 2026', '2026-11-01', 'Soweto, Johannesburg', 'Starting at Orlando Stadium, through Soweto streets, finishing at Dobsonville Stadium.', '42.2km', 'Upcoming', 5000),
(2, 2, 'Cape Town Cycle Tour 2027', '2027-03-08', 'Cape Town, Western Cape', 'Starting at the Grand Parade, looping through Chapmans Peak and back to the city.', '109km', 'Upcoming', 3000),
(1, 3, 'Pretoria Charity Walk 2026', '2026-09-15', 'Pretoria, Gauteng', 'Leisurely walk starting at Church Square through the city centre.', '10km', 'Upcoming', 500);
GO

-- ============================================
-- SEED DATA: Event_Categories
-- ============================================

INSERT INTO Event_Categories (EventID, CategoryID)
VALUES
(1, 1),
(2, 2),
(3, 3);
GO

-- ============================================
-- SEED DATA: Enrolments
-- ============================================

INSERT INTO Enrolments (UserID, EventID, EnrolmentDate, Status)
VALUES
(3, 1, '2026-06-01', 'Confirmed'),
(4, 1, '2026-06-05', 'Confirmed'),
(3, 3, '2026-07-10', 'Confirmed'),
(4, 2, '2026-08-01', 'Confirmed');
GO

-- ============================================
-- SEED DATA: Results
-- ============================================

INSERT INTO Results (EnrolmentID, FinishTime, PositionOverall, PositionCategory, Notes)
VALUES
(1, '3:45:22', 120, 15, 'Strong finish in hot conditions'),
(2, '4:10:05', 340, 42, 'First marathon completed');
GO

-- ============================================
-- Verify all tables were created successfully
-- ============================================

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;
GO
