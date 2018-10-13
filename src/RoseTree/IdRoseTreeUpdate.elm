module IdRoseTreeUpdate exposing (..)

-- core
import List

-- selfmade packages
import RoseTree
import IdWrapper
import IdRoseTree
import SvgElement
import IdRoseTreeDisplay

a = 1

update : IdRoseTree.Model SvgElement.Model 
  -> IdRoseTreeDisplay.Msg SvgElement.Msg SvgElement.Model 
  -> ( IdRoseTree.Model SvgElement.Model
     ,  Cmd (IdRoseTreeDisplay.Msg SvgElement.Msg SvgElement.Model)
     )
update model msg = 
  case msg of
    IdRoseTreeDisplay.Direction id itemMsg ->
      --(model, Cmd.none)
      let (res, cmd) = updateHelperRoseTree model id itemMsg
      in (res, Cmd.map (IdRoseTreeDisplay.Direction id) cmd)
    IdRoseTreeDisplay.New id ->
      (model, Cmd.none)
    IdRoseTreeDisplay.CreatedRandom idParent newId ->
      (model, Cmd.none)

updateHelperRoseTree : IdRoseTree.Model SvgElement.Model -> IdWrapper.Id -> SvgElement.Msg -> ( IdRoseTree.Model SvgElement.Model, Cmd SvgElement.Msg)
updateHelperRoseTree tree id msg = 
  let 
    testFunc = (\testTree -> (IdWrapper.getId (RoseTree.root testTree))==id)
    updateFunc = createUpdateHelperTreeItemWithoutId (\svgElementModel -> let (res,cmd) = SvgElement.update msg svgElementModel in res ) -- discard command for now :( HELP!!
  in 
    (RoseTree.findAndUpdate testFunc updateFunc tree, Cmd.none)
  -- if RoseTreeItem.compare msgValue valueToTest then
  --   RoseTreeItem.update msg valueToTest
  -- else
  --   (valueToTest, Cmd.none)

-- RoseTree.findAndUpdate
--findAndUpdate : (RoseTree a -> Bool) -> ( RoseTree a -> RoseTree a) -> RoseTree a -> RoseTree a

createUpdateHelperTreeItemWithoutId : (SvgElement.Model-> SvgElement.Model) -> (IdRoseTree.Model SvgElement.Model -> IdRoseTree.Model SvgElement.Model)
createUpdateHelperTreeItemWithoutId func =
  (\tree ->
    let
      children = RoseTree.children tree
      itemWithId = RoseTree.root tree
      id = IdWrapper.getId itemWithId
      item = IdWrapper.getItem itemWithId
      updatedItem = func item
    in
      (RoseTree.addChildren children (RoseTree.singleton (IdWrapper.Wrapper id updatedItem)))
  )


  
