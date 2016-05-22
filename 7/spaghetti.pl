%fork_id(id, mutex_id)
fork_id(1, fork1).
fork_id(2, fork2).
fork_id(3, fork3).
fork_id(4, fork4).
fork_id(5, fork5).

%fork(philosopher, left fork_id, right fork_id)
%fork placement
fork('Aristotle',5,1).
fork('Kant',1,2).
fork('Spinoza',2,3).
fork('Marx',3,4).
fork('Russel',4,5).

philosophers(SleepTime, Rounds) :-
	mutex_create(fork1),
	mutex_create(fork2),
	mutex_create(fork3),
	mutex_create(fork4),
	mutex_create(fork5),
	% alias allows not to pass philosopher's name as an argument
	now(StartTime),
	thread_create(thinker(SleepTime, Rounds, 0, StartTime), _, [alias('Aristotle')]),
	thread_create(thinker(SleepTime, Rounds, 0, StartTime), _, [alias('Kant')]),
	thread_create(thinker(SleepTime, Rounds, 0, StartTime), _, [alias('Spinoza')]),
	thread_create(thinker(SleepTime, Rounds, 0, StartTime), _, [alias('Marx')]),
	thread_create(thinker(SleepTime, Rounds, 0, StartTime), _, [alias('Russel')]),
	% done
	thread_join('Aristotle',_),
	thread_join('Kant',_),
	thread_join('Spinoza',_),
	thread_join('Marx',_),
	thread_join('Russel',_),
	% cleanup
	mutex_destroy(fork1),
	mutex_destroy(fork2),
	mutex_destroy(fork3),
	mutex_destroy(fork4),
	mutex_destroy(fork5).

thinker(_,0, TotalWaited, StartTime) :-
	thread_self(Name),
	now(End),
	TotalTime is End - StartTime,
	format('~w done. Time spent waiting: ~3fs/~3fs (~2f%)~n', [Name, TotalWaited, TotalTime, TotalWaited/TotalTime*100]),
	flush_output.
	
thinker(MaxSleep, Rounds, TotalWaitedSoFar, StartTime) :-
	think(MaxSleep, Rounds),
	pick_forks(Rounds, TimeWaited),
	eat(MaxSleep, Rounds),
	release_forks(),
	RoundsLeft is Rounds - 1,
	TotalWaited is TotalWaitedSoFar + TimeWaited,
	!, thinker(MaxSleep, RoundsLeft, TotalWaited, StartTime).
	
pick_forks(RoundsLeft, TimeWaited) :-
	thread_self(Who),
	fork(Who, LeftId, RightId),
	fork_id(LeftId, LeftFork),
	fork_id(RightId,RightFork),
	now(Start),
	(random_float > 0.5 ->
		mutex_lock(LeftFork),
		mutex_lock(RightFork)
	;
		mutex_lock(RightFork),
		mutex_lock(LeftFork)
	),
	now(End),
	TimeWaited is End-Start,
	format('[~w]\t~w got hold of both forks after ~3f seconds~n',[RoundsLeft, Who, TimeWaited]),
	flush_output.
	
	

release_forks() :-
	thread_self(Who),
	fork(Who, LeftId, RightId),
	fork_id(LeftId, LeftFork),
	fork_id(RightId,RightFork),
	(random_float > 0.5 ->
		mutex_unlock(RightFork),
		mutex_unlock(LeftFork)
	;
		mutex_unlock(LeftFork),
		mutex_unlock(RightFork)
	).

think(MaxTime, RoundsLeft) :-
	HowLong is random_float * MaxTime,
	thread_self(Who),
	format('[~w] ~w will be thinking for ~3f seconds~n',[RoundsLeft, Who, HowLong]),
	flush_output,
	sleep(HowLong),
	format('[~w] ~w is done thinking~n',[RoundsLeft, Who]),
	flush_output.
	
eat(MaxTime, RoundsLeft) :-
	HowLong is random_float * MaxTime,
	thread_self(Who),
	format('[~w] ~w will be eating for ~3f seconds~n',[RoundsLeft, Who, HowLong]),
	flush_output,
	sleep(HowLong),
	format('[~w]\t ~w is done eating~n',[RoundsLeft, Who]),
	flush_output.
	
now(Timestamp) :-
	get_time(Time),
	convert_time(Time,_,_,_,_,Minutes,Seconds,Milli),
	Timestamp is Minutes * 60 + Seconds + Milli/1000.