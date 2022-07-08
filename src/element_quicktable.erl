-module(element_quicktable).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").
-export([
    reflect/0,
    render_element/1
]).

reflect() -> record_info(fields, quicktable).

%% Expects data to be a list of lists, or a list of tuples:
%%
%% [
%% 		[row1_cell1,row1_cell2,row1_cell3],
%% 		[row2_cell1,row2_cell2,row2_cell3],
%% 		...
%% 	].
%%
%%  or
%%
%% [
%% 		{row1_cell1,row1_cell2,row1_cell3},
%% 		{row2_cell1,row2_cell2,row2_cell3},
%% 		...
%% 	].

render_element(Rec = #quicktable{}) ->
    Mode = Rec#quicktable.mode,
    HtmlEncode = Rec#quicktable.html_encode,
    FirstRowIsHeader = Rec#quicktable.first_row_is_header,
    Data = Rec#quicktable.data,
    Class = Rec#quicktable.class,

    case FirstRowIsHeader of
        true ->
            [Header | Rows] = Data,
            HElem = render_row(Header, Mode, HtmlEncode, header),
            RElems = [render_row(Row, Mode, HtmlEncode, row) || Row <- Rows],
            #table{
                header = [HElem],
                class = Class,
                rows = RElems
            };
        false ->
            AllRElems = [render_row(Row, Mode, HtmlEncode, row) || Row <- Data],
            #table{
                class = Class,
                rows = AllRElems
            }
    end.

render_row(Row, Mode, HtmlEncode, Type) ->
    Cells =
        case is_tuple(Row) of
            true -> tuple_to_list(Row);
            false -> Row
        end,
    CellData = lists:map(
        fun(Cell) ->
            case {Type, Mode} of
                {row, body} -> #tablecell{body = Cell};
                {header, body} -> #tableheader{body = Cell};
                {row, text} -> #tablecell{text = Cell, html_encode = HtmlEncode};
                {header, text} -> #tableheader{text = Cell, html_encode = HtmlEncode}
            end
        end,
        Cells
    ),
    #tablerow{cells = CellData}.
