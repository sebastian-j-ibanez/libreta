import { For, createResource } from "solid-js";
import { getBoardsMock } from "../api/data";

export default function Sidebar() {
  const [boardNames] = createResource(getBoardsMock);

  return (
    <div class="h-full py-2 max-w-80 justify-items-center border-r border-neutral-400">
      <div>
        <h1 class="text-4xl text-center px-4 pt-4">Libreta</h1>
      </div>
      <div class="text-2xl left-0 top-0 items-center py-4">
        <ul class="justify-items-center">
          <For each={boardNames()}>
            {(board) => (
              <li class="p-2">
                <button class="font-bold outline-1 w-full rounded-md p-1 hover:bg-neutral-700">
                  {board.name}
                </button>
              </li>
            )}
          </For>
        </ul>
      </div>
    </div>
  );
}
