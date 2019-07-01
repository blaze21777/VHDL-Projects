ENTITY T01_HelloWorldTb IS
END ENTITY;

ARCHITECTURE sim OF T01_HelloWorldTb IS
BEGIN
	-- TODO: Create process with Hello World code here
	PROCESS
	BEGIN

		REPORT "Hello World";
		WAIT;

	END PROCESS;

END ARCHITECTURE;