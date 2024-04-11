-- cd  C:\xampp\mysql\bin
-- mysql -u root -p;
-- Création de la Base de Données
create database spy_operations;

Use spy_operations;

-- Create Agents table
CREATE TABLE Agents (
    IdentificationCode CHAR(36) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Surname VARCHAR(255) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Nationality VARCHAR(255) NOT NULL
);

-- Create Specialties table
CREATE TABLE Specialties (
    SpecialtyID INT AUTO_INCREMENT PRIMARY KEY,
    SpecialtyName VARCHAR(255) NOT NULL
);

-- Create Contacts table
CREATE TABLE Contacts (
    ContactID CHAR(36) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Surname VARCHAR(255) NOT NULL,
    DateOfBirth DATE NOT NULL,
    CodeName VARCHAR(255) NOT NULL UNIQUE,
    Nationality VARCHAR(255) NOT NULL
);

-- Create Administrators table
CREATE TABLE Administrators (
    AdminID CHAR(36) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Surname VARCHAR(255) NOT NULL,
    EmailAddress VARCHAR(255) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    CreationDate DATE NOT NULL
);

-- Create Targets table
CREATE TABLE Targets (
    TargetID CHAR(36) PRIMARY KEY NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Surname VARCHAR(255) NOT NULL,
    DateOfBirth DATE NOT NULL,
    CodeName VARCHAR(255) NOT NULL UNIQUE,
    Nationality VARCHAR(255) NOT NULL
);

-- Create Missions table
CREATE TABLE Missions (
    MissionID CHAR(36) PRIMARY KEY NOT NULL,
    Title VARCHAR(255) NOT NULL UNIQUE,
    Description TEXT,
    CodeName VARCHAR(255) NOT NULL UNIQUE,
    Country VARCHAR(255) NOT NULL,
    MissionType VARCHAR(255) NOT NULL,
    Status VARCHAR(255) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    SpecialtyID INT NOT NULL,
    FOREIGN KEY (SpecialtyID) REFERENCES Specialties(SpecialtyID)
);

-- Create Safehouses table
CREATE TABLE Safehouses (
    SafehouseID INT AUTO_INCREMENT PRIMARY KEY,
    Address VARCHAR(255) NOT NULL,
    Country VARCHAR(255) NOT NULL,
    Type VARCHAR(255) NOT NULL
);

-- Create AgentSpecialties table (Association table for Many-to-Many relationship between Agents and Specialties)
CREATE TABLE AgentSpecialties (
    AgentID CHAR(36),
    SpecialtyID INT,
    PRIMARY KEY (AgentID, SpecialtyID),
    FOREIGN KEY (AgentID) REFERENCES Agents(IdentificationCode),
    FOREIGN KEY (SpecialtyID) REFERENCES Specialties(SpecialtyID)
);

-- Create MissionAgents table (Association table for Many-to-Many relationship between Missions and Agents)
CREATE TABLE MissionAgents (
    MissionID CHAR(36),
    AgentID CHAR(36),
    PRIMARY KEY (MissionID, AgentID),
    FOREIGN KEY (MissionID) REFERENCES Missions(MissionID),
    FOREIGN KEY (AgentID) REFERENCES Agents(IdentificationCode)
);

-- Create MissionContacts table (Association table for Many-to-Many relationship between Missions and Contacts)
CREATE TABLE MissionContacts (
    MissionID CHAR(36),
    ContactID CHAR(36),
    PRIMARY KEY (MissionID, ContactID),
    FOREIGN KEY (MissionID) REFERENCES Missions(MissionID),
    FOREIGN KEY (ContactID) REFERENCES Contacts(ContactID)
);

-- Create MissionTargets table (Association table for Many-to-Many relationship between Missions and Targets)
CREATE TABLE MissionTargets (
    MissionID CHAR(36),
    TargetID CHAR(36),
    PRIMARY KEY (MissionID, TargetID),
    FOREIGN KEY (MissionID) REFERENCES Missions(MissionID),
    FOREIGN KEY (TargetID) REFERENCES Targets(TargetID)
);

-- Create MissionSafehouses table (Association table for Many-to-Many relationship between Missions and Safehouses)
CREATE TABLE MissionSafehouses (
    MissionID CHAR(36),
    SafehouseID INT,
    PRIMARY KEY (MissionID, SafehouseID),
    FOREIGN KEY (MissionID) REFERENCES Missions(MissionID),
    FOREIGN KEY (SafehouseID) REFERENCES Safehouses(SafehouseID)
);

-- Insert data into Agents table
INSERT INTO Agents (IdentificationCode, Name, Surname, DateOfBirth, Nationality)
VALUES
    ('487ef5c9-a0d2-11ee-8705-34415d41899', 'John', 'Doe', '1990-01-01', 'USA'),
    ('a0d25b9f-a0d2-11ee-8705-34415d41899', 'Jane', 'Smith', '1985-03-15', 'UK');

-- Insert data into Contacts table
INSERT INTO Contacts (ContactID, Name, Surname, DateOfBirth, CodeName, Nationality)
VALUES
    ('487ef5c9-a0d2-11ee-8705-34415d41898', 'Michael', 'Johnson', '1988-05-20', 'Shadow', 'Russia'),
    ('a0d25b9f-a0d2-11ee-8705-34415d41898', 'Emily', 'Brown', '1992-09-10', 'Ghost', 'France');

-- Insert data into Administrators table (admin_password : A6minP@$$w0r6)
INSERT INTO Administrators (AdminID, Name, Surname, EmailAddress, PasswordHash, CreationDate)
VALUES
    ('487ef5c9-a0d2-11ee-8705-34415d41897', 'Admin', 'Adminson', 'admin@example.com', '$2y$10$NUgkWY5ITHem8PNlUf6xOOCeJ73mjWGgUF85BwhzpnZcTs17.l7pW', '2024-04-12');

-- Insert data into Targets table
INSERT INTO Targets (TargetID, Name, Surname, DateOfBirth, CodeName, Nationality)
VALUES
    ('487ef5c9-a0d2-11ee-8705-34415d41896', 'Alex', 'Wilson', '1975-12-10', 'Snake', 'Germany'),
    ('a0d25b9f-a0d2-11ee-8705-34415d41897', 'Emma', 'Davis', '1980-08-25', 'Viper', 'China');

-- Insert fictive data into Specialties table
INSERT INTO Specialties (SpecialtyName)
VALUES
    ('Surveillance'),
    ('Assassination'),
    ('Infiltration'),
    ('Intelligence Gathering');


-- Insert data into Missions table
INSERT INTO Missions (MissionID, Title, Description, CodeName, Country, MissionType, Status, StartDate, EndDate, SpecialtyID)
VALUES
    ('487ef5c9-a0d2-11ee-8705-34415d41895', 'Operation X', 'Covert operation to gather intelligence', 'OpX', 'Russia', 'Surveillance', 'In preparation', '2024-05-01', '2024-05-15', 1),
    ('a0d25b9f-a0d2-11ee-8705-34415d41896', 'Mission Alpha', 'Assassination mission against high-value target', 'MAlpha', 'France', 'Assassination', 'In progress', '2024-04-20', '2024-05-10', 2);

-- Insert data into Safehouses table
INSERT INTO Safehouses (Address, Country, Type)
VALUES
    ('123 Main St', 'USA', 'Residence'),
    ('456 Oak St', 'UK', 'Office');

-- Insert data into AgentSpecialties table
INSERT INTO AgentSpecialties (AgentID, SpecialtyID)
VALUES
    ('487ef5c9-a0d2-11ee-8705-34415d41899', 1),
    ('a0d25b9f-a0d2-11ee-8705-34415d41899', 2);

-- Insert data into MissionAgents table
INSERT INTO MissionAgents (MissionID, AgentID)
VALUES
    ('487ef5c9-a0d2-11ee-8705-34415d41895', '487ef5c9-a0d2-11ee-8705-34415d41899'),
    ('a0d25b9f-a0d2-11ee-8705-34415d41896', 'a0d25b9f-a0d2-11ee-8705-34415d41899');

-- Insert data into MissionContacts table
INSERT INTO MissionContacts (MissionID, ContactID)
VALUES
    ('487ef5c9-a0d2-11ee-8705-34415d41895', '487ef5c9-a0d2-11ee-8705-34415d41898'),
    ('a0d25b9f-a0d2-11ee-8705-34415d41896', 'a0d25b9f-a0d2-11ee-8705-34415d41898');

-- Insert data into MissionTargets table
INSERT INTO MissionTargets (MissionID, TargetID)
VALUES
    ('487ef5c9-a0d2-11ee-8705-34415d41895', '487ef5c9-a0d2-11ee-8705-34415d41896'),
    ('a0d25b9f-a0d2-11ee-8705-34415d41896', 'a0d25b9f-a0d2-11ee-8705-34415d41897');

-- Insert data into MissionSafehouses table
INSERT INTO MissionSafehouses (MissionID, SafehouseID)
VALUES
    ('487ef5c9-a0d2-11ee-8705-34415d41895', 1),
    ('a0d25b9f-a0d2-11ee-8705-34415d41896', 2);
