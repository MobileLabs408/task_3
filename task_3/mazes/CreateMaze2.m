%--------------------------------------------------------------------------

MazeSize = 80; 

Maze.map = zeros(MazeSize);
Maze.start = [20 20]; % Start point
Maze.goal = [60 60]; % Goal point

%--------------------------------------------------------------------------

% Obstacles and walls
Maze.map(15:25,30)=inf;
Maze.map(35:45,30)=inf;
Maze.map(55:65,30)=inf;

Maze.map(15:65,40)=inf;

Maze.map(60:80,45)=inf;
Maze.map(45,34:40)=inf;
Maze.map(30,40:52)=inf;
Maze.map(25,30:37)=inf;
Maze.map(10,25:35)=inf;
Maze.map(15,40:45)=inf;
Maze.map(5:10,27)=inf;
Maze.map(30,30:35)=inf;
Maze.map(24,18:27)=inf;
Maze.map(45,20:30)=inf;

Maze.map(15:25,50)=inf;
Maze.map(35:45,50)=inf;
Maze.map(55:65,50)=inf;

Maze.map(10:20,25)=inf;
Maze.map(30:40,25)=inf;
Maze.map(50:60,25)=inf;

Maze.map(10:20,35)=inf;
Maze.map(30:40,35)=inf;
Maze.map(50:60,35)=inf;

% Additional obstacles
Maze.map(25:30,55)=inf;
Maze.map(40:50,55)=inf;
Maze.map(65:75,55)=inf;

Maze.map(20:25,65)=inf;
Maze.map(35:45,65)=inf;
Maze.map(55:65,65)=inf;

Maze.map(5:15,70)=inf;
Maze.map(30:40,70)=inf;
Maze.map(50:60,70)=inf;

%--------------------------------------------------------------------------

% Saves the maze structure
save('Maze2.mat','Maze');

%--------------------------------------------------------------------------