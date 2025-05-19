DELIMITER $$

CREATE TRIGGER trg_check_quantity_received
BEFORE INSERT ON OrderDetails
FOR EACH ROW
BEGIN
  IF NEW.QuantityRecieved > NEW.QuantityOrdered THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'QuantityReceived cannot be greater than QuantityOrdered';
  END IF;
END $$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER trg_update_quantity_in_hand
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
  UPDATE ItemDetails
    SET QuantityInHand = QuantityInHand + NEW.QuantityRecieved
  WHERE ItemID = NEW.ItemID;
END $$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER trg_check_receiving_date
BEFORE INSERT ON OrderDetails
FOR EACH ROW
BEGIN
  IF NEW.RecievingDate <= NEW.OrderDate THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'ReceivingDate must be greater than OrderDate';
  END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_check_order_date
BEFORE INSERT ON OrderDetails
FOR EACH ROW
BEGIN
  IF NEW.OrderDate > CURRENT_DATE THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'OrderDate cannot be in the future';
  END IF;
END $$

DELIMITER ;
