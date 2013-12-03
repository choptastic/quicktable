-module (element_quicktable).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").

reflect() -> record_info(fields, quicktable).

%% Expects data to be a list of lists. IE
%%
%% [
%% 		[row1_cell1,row1_cell2,row1_cell3],
%% 		[row2_cell1,row2_cell2,row2_cell3],
%% 		...
%% 	].
render_element(Rec = #quicktable{}) ->
	#table{
		class=Rec#quicktable.class,
		rows=lists:map(fun(Row) ->
			#tablerow{cells=lists:map(fun(Cell) ->
				case Rec#quicktable.mode of
					body -> #tablecell{body=Cell};
					text -> #tablecell{text=Cell,html_encode=Rec#quicktable.html_encode}
				end
			end,Row)}
		end,Rec#quicktable.data)
	}.
