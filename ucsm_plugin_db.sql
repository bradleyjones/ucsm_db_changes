use neutron;

DELIMITER $$
DROP PROCEDURE IF EXISTS add_columns_if_not_exist $$
CREATE PROCEDURE add_columns_if_not_exist()
BEGIN
    IF NOT EXISTS( (SELECT * FROM information_schema.COLUMNS WHERE TABLE_SCHEMA='neutron'
            AND COLUMN_NAME='device_id' AND TABLE_NAME='ml2_ucsm_port_profiles') ) THEN
        ALTER TABLE ml2_ucsm_port_profiles ADD device_id varchar(64) NOT NULL;
    END IF;
END $$
DELIMITER ;

CALL add_columns_if_not_exist();

CREATE TABLE IF NOT EXISTS ml2_ucsm_sp_templates
(vlan_id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
sp_template varchar(64) NOT NULL,
device_id varchar(64) NOT NULL,
updated_on_ucs tinyint(1) NOT NULL,
port_count int(11) NOT NULL);

CREATE TABLE IF NOT EXISTS ml2_ucsm_vnic_templates
(vlan_id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
vnic_template varchar(64) NOT NULL,
device_id varchar(64) NOT NULL,
physnet varchar(32) NOT NULL,
updated_on_ucs tinyint(1) NOT NULL,
port_count int(11) NOT NULL);
