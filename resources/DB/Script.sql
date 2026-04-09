PRAGMA user_version = 1;
PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS Sessions
	(
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		user_id INTEGER NOT NULL,
		token TEXT UNIQUE NOT NULL,
		expires_at DATETIME NOT NULL,

		FOREIGN KEY(user_id) REFERENCES Users(id)
	);

CREATE TABLE IF NOT EXISTS Roles 
	(
	    id INTEGER PRIMARY KEY AUTOINCREMENT,
	    role TEXT UNIQUE NOT NULL,
	    tag_color TEXT
	);

CREATE TABLE IF NOT EXISTS Resources 
	(
	    id INTEGER PRIMARY KEY AUTOINCREMENT,
	    name TEXT UNIQUE NOT NULL
	);

CREATE TABLE IF NOT EXISTS AccessLevels 
	(
	    id INTEGER PRIMARY KEY,
	    level TEXT UNIQUE NOT NULL
	);

CREATE TABLE IF NOT EXISTS RolePermissions 
	(
	    role_id INTEGER,
	    resource_id INTEGER,
	    level_id INTEGER,

	    PRIMARY KEY (role_id, resource_id),
	    FOREIGN KEY(role_id) REFERENCES Roles(id),
	    FOREIGN KEY(resource_id) REFERENCES Resources(id),
	    FOREIGN KEY(level_id) REFERENCES AccessLevels(id)
	);

CREATE TABLE IF NOT EXISTS Users
	(
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		login TEXT UNIQUE  NOT NULL,
		password_hash TEXT NOT NULL,
		name TEXT NOT NULL,
		role_id INTEGER NOT NULL,

	    FOREIGN KEY(role_id) REFERENCES Roles(id)
	        ON DELETE RESTRICT
	        ON UPDATE CASCADE
	);

CREATE TABLE IF NOT EXISTS Clients
	(
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		name TEXT NOT NULL,
		email TEXT,
		phone TEXT,
		communication_id INTEGER NOT NULL,

		FOREIGN KEY(communication_id) REFERENCES Communication(id)
	);

CREATE TABLE IF NOT EXISTS Communication
	(
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		place TEXT UNIQUE NOT NULL
	);

CREATE TABLE IF NOT EXISTS Deals 
	(
	    id INTEGER PRIMARY KEY AUTOINCREMENT,
	    client_id INTEGER  NOT NULL,
	    manager_id INTEGER NOT NULL,
	    delivery_date DATETIME DEFAULT CURRENT_TIMESTAMP,
	    expiration_date DATETIME,
	    description TEXT,
	    status_id INTEGER,
	    amount REAL NOT NULL,

	    FOREIGN KEY(client_id)  REFERENCES Clients(id),
	    FOREIGN KEY(manager_id) REFERENCES Users(id),
	    FOREIGN KEY(status_id)  REFERENCES Status(id)
	);

CREATE TABLE IF NOT EXISTS Tasks 
	(
	    id INTEGER PRIMARY KEY AUTOINCREMENT,
	    client_id INTEGER NOT NULL,
	    assigned_to INTEGER,
	    deadline DATETIME,
	    description TEXT,
	    status_id INTEGER NOT NULL,

	    FOREIGN KEY(client_id)   REFERENCES Clients(id),
	    FOREIGN KEY(assigned_to) REFERENCES Users(id),
	    FOREIGN KEY(status_id)   REFERENCES Status(id)
	);

CREATE TABLE IF NOT EXISTS Status
	(
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		state TEXT UNIQUE NOT NULL
	);

INSERT OR IGNORE INTO Roles (role, tag_color)
VALUES 	('Admin', 'red'), ('Manager', 'blue'), ('Employee', 'green');

INSERT OR IGNORE INTO Users (login, name, password_hash, role_id) 
VALUES	('Admin', 'Ilya', '$2a$12$PoZpGMeDO.4UzW/3DjTCn.qpxcjtYaQsAq86BlN.6FrHhUd8Hnij6', 1);

INSERT OR IGNORE INTO AccessLevels (level)
VALUES	('forbidden'), ('read'), ('edit');

INSERT OR IGNORE INTO Resources (name)
VALUES 	('users'), ('roles'), ('clients'), ('deals'), ('tasks');

-- role | res | perm
INSERT OR IGNORE INTO RolePermissions
VALUES 	(1, 1, 3),
		(1, 2, 3),
		(1, 3, 3),
		(1, 4, 3),
		(1, 5, 3);