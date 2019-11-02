% 实现一个优先队列

:- op(400, yfx, '#').  % 这一行是必须的,别问为什么

precedes(X,Y) :- X < Y. % 优先队列的排序规则

% 参数介绍, 第一个参数State是要插入优先队列的元素，第二个参数是当前的优先队列，第三个参数是插入后的优先队列
% 在这里我定义优先队列的元素是一个结构体struct, struct包含两个变量，一个表示当前的处于哪个状态，即State，另一个表示当前状态的启发式函数值，F
% 在prolog中，结构体的一种表达方式是用'#'把成员变量连接起来，如我想要定义一个包含两个变量的结体，
% struct{
%		state1,
%		10
%}
% 在prolog中用state1#10就可以表示了

insert_priority_queue(X, [], [X]).  % 优先队列是空的情况

insert_priority_queue(State#F, [State1#F1 | Tail], [State#F, State1#F1 | Tail]):-  % 如果要插入的结构体的f值小于优先队列队首元素的f值，则让新插入的结构体位于优先队列的队首
	precedes(F, F1).  

insert_priority_queue(State#F, [State1#F1 | T], [State1#F1 | Tnew]):- % 否则的话递归调用即可，有点像插入排序，你们自己看这个代码慢慢领会
	insert_priority_queue(State#F, T, Tnew).