/* Sara really needed to go to the doctor for her check-up... and to her dentist, chiropractor, and optometrist. All four had been persistently reminding her that she was overdue for check-ups. But she'd been travelling a lot for work and just hadn't had the time to make her appointments. So, in a fit of reckless abandon, she scheduled all FOUR of them for the same day – next Tuesday, the one day she was home between two business trips. Getting four appointments in the same day was a challenge but fortunately they were all in the same medical center so she didn’t have to allow for travel time. Determine the time of each appointment (times were 9:00 am, 11:30 am, 1:00 pm, and 3:30 pm), the type of doctor she was seeing, how long each appointment was scheduled for (1/2 hour or 1 hour), and each doctor’s name.

1. Sara's one-hour appointments were scheduled with Dr. Borne and the dentist.

2. Her appointment with Dr. Swan was scheduled for half an hour.

3. Dr. Bigelow was the physician.

4. The appointment with her optometrist was scheduled to start on the half hour.

5. She saw her chiropractor before Dr. Swan but after her appointment with Dr. Mann.

6. Her appointment with Dr. Mann wasn't at 9:00 am.
Sol = [[Doctor, Practice, Time, Length],...]
*/

practices([physician, dentist, optometrist, chiropractor]).
doctors([borne, bigelow, swan, mann]).
times([900, 1130, 100, 330]).
lengths([30, 300, 60, 600]). % PLEASE NOTE: Since duplicate values make Prolog programming more complex, I chose to give the two 30-minute time slots and
% the two 60-minute time slots two seperate values. However, both 30 and 300 represent 30 minute time slots; likewise with 60 and 600.


myremove(X,[X|T],T). % Procedure also comes from the below library.
myremove(X,[H|T],[H|R]):-myremove(X,T,R).

% Procedure comes from this library: http://www.anselm.edu/internet/compsci/faculty_staff/mmalita/HOMEPAGE/logic/bibmm.txt.
set_equal([],[]). % This procedure also comes from the above extremely useful library.
set_equal([H|T],R):- member(H,R),myremove(H,R,Rez),set_equal(T,Rez). % As does this one.

start(Sol):- doctors(D), practices(P), times(T), lengths(L),
Sol=[[D1, P1, T1, L1],
[D2, P2, T2, L2],
[D3, P3, T3, L3],
[D4, P4, T4, L4]
],

% 1. Sara's one-hour appointments were scheduled with Dr. Borne and the dentist.

member([borne,_,_,60], Sol),
member([_,dentist,_,600], Sol),

% So her half-hour appointments were
member([_,_,_,30],Sol),
member([_,_,_,300],Sol),

% 2. Her appointment with Dr. Swan was scheduled for half an hour.
(member([swan,_,_,30], Sol) ; member([swan,_,_,300], Sol)),

% 3. Dr. Bigelow was the physician.
member([bigelow, physician,_,_], Sol),

% 4. The appointment with her optometrist was scheduled to start on the half hour.
(member([_,optometrist,330,_], Sol) ; member([_,optometrist,1130,_],Sol)),

% 5. She saw her chiropractor before Dr. Swan but after her appointment with Dr. Mann.
% Alternately, she saw her chiropractor between two other times, meaning at 1130 (between 900 and 100)
% or 100 (between 1130 and 330).
((member([mann,_,1130,_], Sol), member([_,chiropractor,100,_], Sol), member([swan,_,330,_],Sol)) ;
(member([mann,_,900,_],Sol), member([_,chiropractor,1130,_],Sol), member([swan,_,100,_],Sol))),

% 6. Her appointment with Dr. Mann wasn't at 9:00 am.
(member([mann,_,100,_], Sol) ; member([mann,_,1130,_],Sol) ; member([mann,_,330,_],Sol)),

set_equal([D1,D2,D3,D4],D),
set_equal([P1,P2,P3,P4],P),
set_equal([T1,T2,T3,T4],T),
set_equal([L1,L2,L3,L4],L).