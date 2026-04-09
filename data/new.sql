PRAGMA foreign_keys = ON;

-- =========================
--  LABELS (NARRATIVE NODES)
-- =========================
CREATE TABLE label (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL        -- internal name for Ren'Py (used as label name)
);

-- =========================
--  CHARACTERS
-- =========================
CREATE TABLE character_data (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    color TEXT                  -- e.g. "#ffffff" for name color in dialogue
);

-- =========================
--  EFFECTS (METADATA ONLY)
-- =========================
CREATE TABLE effect (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,         -- e.g. "fade", "dissolve", "zoom", "fadein"
    num_variable REAL           -- optional parameter (duration, intensity, etc.)
);

-- =========================
--  RESOURCES (FILES)
-- =========================
CREATE TABLE resource (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,         -- logical name in the editor
    path TEXT NOT NULL,         -- file path used for export
    filetype TEXT NOT NULL,     -- "image", "music", "sound", "video"
    effect_id INTEGER,          -- optional default effect for this resource
	purpose TEXT,              	-- "background", "sprite", "music", "sound"
    FOREIGN KEY (effect_id) REFERENCES effect(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- =========================================
--  LABEL ↔ RESOURCE (WHAT EACH LABEL USES)
-- =========================================
CREATE TABLE label_resource (
    label_id INTEGER NOT NULL,
    resource_id INTEGER NOT NULL,
    PRIMARY KEY (label_id, resource_id),
    FOREIGN KEY (label_id) REFERENCES label(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (resource_id) REFERENCES resource(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =========================
--  DIALOGS
-- =========================
CREATE TABLE dialog (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    label_id INTEGER NOT NULL,
    character_id INTEGER,       -- nullable: narrator lines have no character
    text TEXT NOT NULL,
    FOREIGN KEY (label_id) REFERENCES label(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (character_id) REFERENCES character_data(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- =========================
--  MENUS (REN'PY MENU BLOCK)
-- =========================
CREATE TABLE menu (
    label_id INTEGER PRIMARY NULL UNIQUE,
    text TEXT NOT NULL,
    PRIMARY KEY (label_id),
    FOREIGN KEY (label_id) REFERENCES label(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =========================
--  DECISIONS (MENU OPTIONS)
-- =========================
CREATE TABLE decision (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    menu_id INTEGER NOT NULL,
    text_description TEXT NOT NULL,    -- text shown in the menu option
    label_id_to_jump INTEGER NOT NULL, -- target label when chosen
    FOREIGN KEY (menu_id) REFERENCES menu(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (label_id_to_jump) REFERENCES label(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);