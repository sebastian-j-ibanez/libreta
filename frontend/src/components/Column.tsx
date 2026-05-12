import { createResource, For } from "solid-js";
import { getCardsMock, type Column } from "../api/data";
import Card from "./Card";

export default function Column(props: { column: Column }) {
  const [cards] = createResource(getCardsMock);
  return (
    <div class="mx-2 min-w-100 border-neutral-600 border-2 rounded-lg">
      <div id="column header" class="grid-row row-span-full">
        <div class="text-xl text-center pt-4">{props.column.name}</div>
      </div>
      <div id="column-cards" class="justify-items-center">
        <For each={cards()}>{(card) => <Card card={card} />}</For>
      </div>
    </div>
  );
}
