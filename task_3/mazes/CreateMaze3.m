%--------------------------------------------------------------------------

MazeSize = 80; 

Maze.map = zeros(MazeSize);
Maze.start = [5, 5]; % Start point
Maze.goal = [75, 75]; % Goal point

%--------------------------------------------------------------------------

% Obstacles and walls
Maze.map(10:20,5:10)=inf; % Top left corner obstacle
Maze.map(5,10:20)=inf;

Maze.map(15:25,30:35)=inf; % Central rectangle obstacle (broken in half)
Maze.map(30,15:45)=inf;

Maze.map(40:50,20:25)=inf; % Smaller rectangle obstacle on top
Maze.map(45,15:30)=inf;  % Connects to previous wall

Maze.map(1:30,45)=inf;
Maze.map(55:60,35)=inf;
Maze.map(50:55,70)=inf;
Maze.map(65,60:65)=inf;
Maze.map(43:55,45)=inf;
Maze.map(50:60,22)=inf;
Maze.map(65:73,32)=inf;
Maze.map(73,16:32)=inf;
Maze.map(63:78,73)=inf;
Maze.map(78,73:77)=inf;
Maze.map(70:78,77)=inf;
Maze.map(63,73:77)=inf;
Maze.map(27:40,50)=inf;
Maze.map(25:40,75)=inf;

Maze.map(1,1:80)=inf;
Maze.map(80,1:80)=inf;
Maze.map(1:80,1)=inf;
Maze.map(1:80,80)=inf;

Maze.map(35:45,40)=inf; % Vertical wall with deceptive gap (gap leads nowhere)
Maze.map(40,35:50)=inf; % Connects to previous wall

Maze.map(50:60,50:55)=inf; % Square dead end disguised as path (center)
Maze.map(55,45:60)=inf;  % Connects dead end

Maze.map(60:65,30:35)=inf; % Smaller rectangle obstacle on bottom
Maze.map(30,60:70)=inf;  % Connects to previous wall

Maze.map(55:65,65:70)=inf; % Right dead end disguised as path
Maze.map(65,50:60)=inf;  % Connects dead end

Maze.map(68:73,40:45)=inf; % Looping wall with deceptive gap (gap leads nowhere)
Maze.map(45,65:78)=inf;  % Connects to previous wall (challenging path)

Maze.map(20:30,25:30)=inf; % Left dead end disguised as path
Maze.map(25,20:35)=inf;  % Connects dead end

Maze.map(10:20,65:70)=inf; % Right corner obstacle with gap (gap leads nowhere)
Maze.map(65,10:25)=inf;  % Connects to previous wall

Maze.map(35:45,55:60)=inf; % Intersecting wall (creates confusion)
Maze.map(55,35:45)=inf;  % Connects intersecting wall

Maze.map(40:50,70:75)=inf; % Vertical wall with gap near goal (gap much smaller)
Maze.map(70,40:55)=inf;  % Connects to previous wall

%--------------------------------------------------------------------------

%Saves the maze structure
save('Maze3.mat','Maze');

%--------------------------------------------------------------------------