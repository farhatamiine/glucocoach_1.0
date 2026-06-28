"use client";

import {
    Dialog,
    DialogClose,
    DialogContent,
    DialogDescription,
    DialogFooter,
    DialogHeader,
    DialogTitle,
} from "@/components/ui/dialog";
import {Button} from "@/components/ui/button";

type ConfirmDialogProps = {
    open: boolean;
    onOpenChange: (open: boolean) => void;
    title: string;
    description?: string;
    confirmLabel?: string;
    onConfirm: () => void;
    isPending?: boolean;
};

export function ConfirmDialog({
                                  open,
                                  onOpenChange,
                                  title,
                                  description,
                                  confirmLabel = "Delete",
                                  onConfirm,
                                  isPending,
                              }: ConfirmDialogProps) {
    return (
        <Dialog open={open} onOpenChange={onOpenChange}>
            <DialogContent className="max-w-xs rounded-lg">
                <DialogHeader>
                    <DialogTitle>{title}</DialogTitle>
                    {description && <DialogDescription>{description}</DialogDescription>}
                </DialogHeader>
                <DialogFooter className="gap-2">
                    <DialogClose asChild>
                        <Button variant="outline" className="h-9">
                            Cancel
                        </Button>
                    </DialogClose>
                    <Button variant="destructive" className="h-9" onClick={onConfirm} disabled={isPending}>
                        {isPending ? "Deleting…" : confirmLabel}
                    </Button>
                </DialogFooter>
            </DialogContent>
        </Dialog>
    );
}
