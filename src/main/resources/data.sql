SET
FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `mbooks__dev`.`batch_job_execution`;

CREATE TABLE `mbooks__dev`.`batch_job_execution`
(
    `JOB_EXECUTION_ID` BIGINT(20) NOT NULL,
    `VERSION`          BIGINT(20) DEFAULT NULL,
    `JOB_INSTANCE_ID`  BIGINT(20) NOT NULL,
    `CREATE_TIME`      DATETIME(6) NOT NULL,
    `START_TIME`       DATETIME(6) DEFAULT NULL,
    `END_TIME`         DATETIME(6) DEFAULT NULL,
    `STATUS`           VARCHAR(10)   DEFAULT NULL,
    `EXIT_CODE`        VARCHAR(2500) DEFAULT NULL,
    `EXIT_MESSAGE`     VARCHAR(2500) DEFAULT NULL,
    `LAST_UPDATED`     DATETIME(6) DEFAULT NULL,
    PRIMARY KEY (`JOB_EXECUTION_ID`),
    KEY                `JOB_INST_EXEC_FK` (`JOB_INSTANCE_ID`),
    CONSTRAINT `JOB_INST_EXEC_FK` FOREIGN KEY (`JOB_INSTANCE_ID`) REFERENCES `batch_job_instance` (`JOB_INSTANCE_ID`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `mbooks__dev`.`batch_job_execution_context`;

CREATE TABLE `mbooks__dev`.`batch_job_execution_context`
(
    `JOB_EXECUTION_ID`   BIGINT(20) NOT NULL,
    `SHORT_CONTEXT`      VARCHAR(2500) NOT NULL,
    `SERIALIZED_CONTEXT` TEXT DEFAULT NULL,
    PRIMARY KEY (`JOB_EXECUTION_ID`),
    CONSTRAINT `JOB_EXEC_CTX_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `mbooks__dev`.`batch_job_execution_params`;

CREATE TABLE `mbooks__dev`.`batch_job_execution_params`
(
    `JOB_EXECUTION_ID` BIGINT(20) NOT NULL,
    `PARAMETER_NAME`   VARCHAR(100) NOT NULL,
    `PARAMETER_TYPE`   VARCHAR(100) NOT NULL,
    `PARAMETER_VALUE`  VARCHAR(2500) DEFAULT NULL,
    `IDENTIFYING`      CHAR(1)      NOT NULL,
    KEY                `JOB_EXEC_PARAMS_FK` (`JOB_EXECUTION_ID`),
    CONSTRAINT `JOB_EXEC_PARAMS_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `mbooks__dev`.`batch_job_instance`;

CREATE TABLE `mbooks__dev`.`batch_job_instance`
(
    `JOB_INSTANCE_ID` BIGINT(20) NOT NULL,
    `VERSION`         BIGINT(20) DEFAULT NULL,
    `JOB_NAME`        VARCHAR(100) NOT NULL,
    `JOB_KEY`         VARCHAR(32)  NOT NULL,
    PRIMARY KEY (`JOB_INSTANCE_ID`),
    UNIQUE KEY `JOB_INST_UN` (`JOB_NAME`,`JOB_KEY`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `mbooks__dev`.`batch_step_execution`;

CREATE TABLE `mbooks__dev`.`batch_step_execution`
(
    `STEP_EXECUTION_ID`  BIGINT(20) NOT NULL,
    `VERSION`            BIGINT(20) NOT NULL,
    `STEP_NAME`          VARCHAR(100) NOT NULL,
    `JOB_EXECUTION_ID`   BIGINT(20) NOT NULL,
    `CREATE_TIME`        DATETIME(6) NOT NULL,
    `START_TIME`         DATETIME(6) DEFAULT NULL,
    `END_TIME`           DATETIME(6) DEFAULT NULL,
    `STATUS`             VARCHAR(10)   DEFAULT NULL,
    `COMMIT_COUNT`       BIGINT(20) DEFAULT NULL,
    `READ_COUNT`         BIGINT(20) DEFAULT NULL,
    `FILTER_COUNT`       BIGINT(20) DEFAULT NULL,
    `WRITE_COUNT`        BIGINT(20) DEFAULT NULL,
    `READ_SKIP_COUNT`    BIGINT(20) DEFAULT NULL,
    `WRITE_SKIP_COUNT`   BIGINT(20) DEFAULT NULL,
    `PROCESS_SKIP_COUNT` BIGINT(20) DEFAULT NULL,
    `ROLLBACK_COUNT`     BIGINT(20) DEFAULT NULL,
    `EXIT_CODE`          VARCHAR(2500) DEFAULT NULL,
    `EXIT_MESSAGE`       VARCHAR(2500) DEFAULT NULL,
    `LAST_UPDATED`       DATETIME(6) DEFAULT NULL,
    PRIMARY KEY (`STEP_EXECUTION_ID`),
    KEY                  `JOB_EXEC_STEP_FK` (`JOB_EXECUTION_ID`),
    CONSTRAINT `JOB_EXEC_STEP_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `mbooks__dev`.`batch_step_execution_context`;

CREATE TABLE `mbooks__dev`.`batch_step_execution_context`
(
    `STEP_EXECUTION_ID`  BIGINT(20) NOT NULL,
    `SHORT_CONTEXT`      VARCHAR(2500) NOT NULL,
    `SERIALIZED_CONTEXT` TEXT DEFAULT NULL,
    PRIMARY KEY (`STEP_EXECUTION_ID`),
    CONSTRAINT `STEP_EXEC_CTX_FK` FOREIGN KEY (`STEP_EXECUTION_ID`) REFERENCES `batch_step_execution` (`STEP_EXECUTION_ID`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

SET
FOREIGN_KEY_CHECKS = 1;