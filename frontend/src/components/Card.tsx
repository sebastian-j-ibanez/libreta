import { createResource, createSignal } from "solid-js";
import { getCardsMock, type Card } from "../api/data";

export default function Card(props: { card: Card }) {
  const [checked, checkBox] = createSignal(props.card.complete);
  const check = () => checkBox((is_checked) => (is_checked ? false : true));
  return (
    <div class="m-4 justify-items-center min-h-20 border-amber-50 border rounded-lg">
      <div class="flex justify-between">
        <div class="font-bold text-left m-3 ml-4">{props.card.title}</div>
        <button class="justify-self-end mr-4" onclick={check}>
          {checked() ? "[x]" : "[ ]"}
        </button>
      </div>
      <div>
        <div class="font-thin m-3 ml-4">{props.card.description}</div>
      </div>
    </div>
  );
}
