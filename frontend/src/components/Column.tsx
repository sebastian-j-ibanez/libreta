import { type Column } from "../api/data";

export default function Column(props: { column: Column }) {
  return (
    <div class="mx-2 min-w-100 border-neutral-600 border-2 rounded-lg">
      <div class="grid-row row-span-full">
        <div class="text-xl text-center pt-4">{props.column.name}</div>
      </div>
    </div>
  );
}
