import { For, createResource } from "solid-js";
import { getColumnsMock } from "../api/data";
import Column from "./Column";

export default function Board() {
  const [columns] = createResource(getColumnsMock);
  return (
    <div class="flex w-full h-full px-8 py-8 overflow-auto">
      <For each={columns()}>{(column) => <Column column={column} />}</For>
    </div>
  );
}
